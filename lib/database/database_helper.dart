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
  static const int _databaseVersion = 1;

  static const String columnId = 'id';
  static const String tableOperations = 'operations';
  static const String columnMachine = 'machine';
  static const String columnNameCode = 'nameCode';
  static const String columnCode = 'code';
  static const String columnName = 'name';
  static const String columnNote = 'notes';
  static const String columnImages = 'images';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      // Явно указываем путь к базе данных
      final String databasePath = await getDatabasesPath();
      final String path = join(databasePath, _databaseName);
      if (kDebugMode) {
        print('путь базы данных: $path');
      }
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
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
    await db.execute(''' 
    CREATE TABLE $tableOperations (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnMachine TEXT NOT NULL,
    $columnNameCode TEXT NOT NULL,
    $columnCode TEXT UNIQUE,    
    $columnName TEXT NOT NULL,
    $columnNote TEXT,
    $columnImages TEXT
    )
    ''');
    if (kDebugMode) {
      print('База данных успешно создана.');
    }
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // CRUD операции остаются без изменений
  Future<int> insertOperation(Operation operation) async {
    final db = await database;
    return await db.insert(
      tableOperations,
      operation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Operation>> getAllOperations(
    String machine,
    String nameCode,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOperations,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
      // orderBy: '$columnCode ASC', // Сортировка по коду по возрастанию
    );
    // Создаем копию чтобы не мутировать оригинальные данные
    final sortedData = List<Map<String, dynamic>>.from(maps);

    sortedData.sort((a, b) {
      // Безопасное извлечение значений
      final valueA = a[columnCode]?.toString() ?? '';
      final valueB = b[columnCode]?.toString() ?? '';

      // Извлекаем числа
      final numA = _extractNumber(valueA);
      final numB = _extractNumber(valueB);

      // Сортируем по числам
      final numericCompare = numA.compareTo(numB);

      // Если числа равны, сортируем по оригинальным строкам
      if (numericCompare == 0) {
        return valueA.compareTo(valueB);
      }

      return numericCompare;
    });

    return List.generate(
      sortedData.length,
      (i) => Operation.fromMap(sortedData[i]),
    );
  }

  // Выносим логику извлечения числа в отдельный метод
  int _extractNumber(String value) {
    try {
      final numbersOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
      return int.tryParse(numbersOnly) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<Operation>> getAllGkodTraubOperations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOperations,
      where: '$columnMachine = ?',
      whereArgs: ['TRAUB (TX8H)'],
    );
    return List.generate(maps.length, (i) => Operation.fromMap(maps[i]));
  }

  Future<List<Operation>> getAllOperationsByNotes(String machine) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOperations,
      where:
          '$columnMachine = ? AND ($columnNote != ? AND $columnNote != ? OR $columnImages != ? AND $columnImages != ?)',
      whereArgs: [machine, "", 'null', "", 'null'],
    );
    return List.generate(maps.length, (i) => Operation.fromMap(maps[i]));
  }

  Future<Operation?> getOperation(String code) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOperations,
      where: '$columnCode = ?',
      whereArgs: [code],
    );
    return maps.isNotEmpty ? Operation.fromMap(maps.first) : null;
  }

  Future<Operation?> getOperationById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOperations,
      where: '$columnCode = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Operation.fromMap(maps.first) : null;
  }

  Future<int> updateOperation(Operation operation) async {
    final db = await database;
    return await db.update(
      tableOperations,
      operation.toMap(),
      where: '$columnCode = ?',
      whereArgs: [operation.code],
    );
  }

  Future<int> deleteOperation(String id) async {
    final db = await database;
    return await db.delete(
      tableOperations,
      where: '$columnCode = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllSelectedOperation(
    String machine,
    String nameCode,
  ) async {
    final db = await database;
    return await db.delete(
      tableOperations,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
  }

  Future<int> deleteAllOperation(String machine, String nameCode) async {
    final db = await database;
    return await db.delete(
      tableOperations,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
  }

  Future<int> deleteAllTraubGcodOperation() async {
    final db = await database;
    return await db.delete(
      tableOperations,
      where: '$columnMachine = ? AND $columnMachine = ?',
      whereArgs: ['TRAUB (TX8H)', 'G - kod'],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
