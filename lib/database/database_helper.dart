import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/operation_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String _databaseName = 'operations.db';
  static const int _databaseVersion = 2;

  static const String columnId = 'id';
  static const String columnMachine = 'machine';
  static const String columnNameCode = 'nameCode';
  static const String columnCode = 'code';
  static const String columnName = 'name';
  static const String columnNote = 'notes';
  static const String columnImages = 'images';

  static const List<String> _supportedMachines = [
    'FANUC 0i-tf plus (sowin)',
    'TRAUB (TX8H)',
    'SYNTEC 22TB (blin)'
  ];

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final String databasePath = await getDatabasesPath();
      final String path = join(databasePath, _databaseName);
      if (kDebugMode) {
        print('Путь базы данных: $path');
      }
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка инициализации базы данных: $e');
      }
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Создаем таблицы для каждого станка
    for (final machine in _supportedMachines) {
      await _createMachineTable(db, machine);
    }
    if (kDebugMode) {
      print('База данных успешно создана с таблицами для ${_supportedMachines.length} станков');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Миграция с версии 1 на 2: создаем новые таблицы для каждого станка
      for (final machine in _supportedMachines) {
        await _createMachineTable(db, machine);
      }
      
      // Переносим данные из старой таблицы в новые
      await _migrateDataFromOldTable(db);
      
      // Удаляем старую таблицу
      await db.execute('DROP TABLE IF EXISTS operations');
    }
  }

  Future<void> _migrateDataFromOldTable(Database db) async {
    try {
      // Проверяем, существует ли старая таблица
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='operations'"
      );
      
      if (tables.isNotEmpty) {
        // Переносим данные в соответствующие таблицы станков
        final oldData = await db.query('operations');
        
        for (final data in oldData) {
          final machine = data[columnMachine] as String;
          if (_supportedMachines.contains(machine)) {
            await db.insert(
              _getTableName(machine),
              data,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
        
        if (kDebugMode) {
          print('Миграция данных завершена: ${oldData.length} записей');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка миграции данных: $e');
      }
    }
  }

  Future<void> _createMachineTable(Database db, String machine) async {
    final tableName = _getTableName(machine);
    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnMachine TEXT NOT NULL,
        $columnNameCode TEXT NOT NULL,
        $columnCode TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnNote TEXT,
        $columnImages TEXT,
        UNIQUE($columnMachine, $columnNameCode, $columnCode)
      )
    ''');
    
    // Создаем индексы для улучшения производительности
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_${tableName}_machine_namecode 
      ON $tableName ($columnMachine, $columnNameCode)
    ''');
    
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_${tableName}_code 
      ON $tableName ($columnCode)
    ''');
  }

  String _getTableName(String machine) {
    // Создаем безопасное имя таблицы
    return 'operations_${machine.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase()}';
  }

  Future<void> _onConfigure(Database db) async {
    // Используем rawQuery для PRAGMA команд вместо execute
    await db.rawQuery('PRAGMA foreign_keys = ON');
    await db.rawQuery('PRAGMA journal_mode = WAL');
    await db.rawQuery('PRAGMA synchronous = NORMAL');
  }

  // Получить имя таблицы для конкретного станка
  String getTableNameForMachine(String machine) {
    if (!_supportedMachines.contains(machine)) {
      throw ArgumentError('Неподдерживаемый станок: $machine');
    }
    return _getTableName(machine);
  }

  // Получить список всех таблиц станков
  List<String> getSupportedMachines() {
    return List.from(_supportedMachines);
  }

  // CRUD операции для конкретного станка
  Future<int> insertOperation(Operation operation) async {
    final db = await database;
    final tableName = getTableNameForMachine(operation.machine);
    return await db.insert(
      tableName,
      operation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Operation>> getAllOperations(
    String machine,
    String nameCode,
  ) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
    
    // Сортируем данные
    final sortedData = List<Map<String, dynamic>>.from(maps);
    sortedData.sort((a, b) {
      final valueA = a[columnCode]?.toString() ?? '';
      final valueB = b[columnCode]?.toString() ?? '';
      final numA = _extractNumber(valueA);
      final numB = _extractNumber(valueB);
      final numericCompare = numA.compareTo(numB);
      return numericCompare == 0 ? valueA.compareTo(valueB) : numericCompare;
    });

    return List.generate(
      sortedData.length,
      (i) => Operation.fromMap(sortedData[i]),
    );
  }

  int _extractNumber(String value) {
    try {
      final numbersOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
      return int.tryParse(numbersOnly) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<Operation>> getAllOperationsByNotes(String machine) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where:
          '$columnMachine = ? AND ($columnNote != ? AND $columnNote != ? OR $columnImages != ? AND $columnImages != ?)',
      whereArgs: [machine, "", 'null', "", 'null'],
    );
    return List.generate(maps.length, (i) => Operation.fromMap(maps[i]));
  }

  Future<Operation?> getOperation(String machine, String code) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnCode = ?',
      whereArgs: [code],
    );
    return maps.isNotEmpty ? Operation.fromMap(maps.first) : null;
  }

  Future<int> updateOperation(Operation operation) async {
    final db = await database;
    final tableName = getTableNameForMachine(operation.machine);
    return await db.update(
      tableName,
      operation.toMap(),
      where: '$columnCode = ? AND $columnMachine = ?',
      whereArgs: [operation.code, operation.machine],
    );
  }

  Future<int> deleteOperation(String machine, String code) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    return await db.delete(
      tableName,
      where: '$columnCode = ?',
      whereArgs: [code],
    );
  }

  Future<int> deleteAllSelectedOperation(
    String machine,
    String nameCode,
  ) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    return await db.delete(
      tableName,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
  }

  Future<int> deleteAllOperation(String machine, String nameCode) async {
    final db = await database;
    final tableName = getTableNameForMachine(machine);
    return await db.delete(
      tableName,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
  }

  // Получить статистику по таблицам
  Future<Map<String, int>> getTableStats() async {
    final db = await database;
    final stats = <String, int>{};
    
    for (final machine in _supportedMachines) {
      final tableName = getTableNameForMachine(machine);
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName')
      ) ?? 0;
      stats[machine] = count;
    }
    
    return stats;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}