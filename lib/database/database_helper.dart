import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/operation_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String _databaseName = 'operations.db';
  static const int _databaseVersion = 1;

  static const String columnId = 'id';
  static const String columnMachine = 'machine';
  static const String columnNameCode = 'nameCode';
  static const String columnCode = 'code';
  static const String columnName = 'name';
  static const String columnNote = 'notes';
  static const String columnImages = 'images';

  bool _isInitialized = false;

  // Метод для получения имени таблицы для станка
  String _getTableName(String? machine) {
    final safeName = machine
        ?.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
        .toLowerCase();
    return 'operations_$safeName';
  }

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
        print('путь базы данных: $path');
      }

      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db, version) async {
          await _onCreate(db, version);
        },
        onConfigure: _onConfigure,
        // Добавляем обработчик ошибок открытия
        onOpen: (db) async {
          if (kDebugMode) {
            print('База данных успешно открыта');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка инициализации базы данных: $e');
      }
      rethrow;
    }
  }

  // Добавьте метод для проверки и создания всех таблиц
  Future<void> ensureTablesCreated() async {
    final db = await database;
    // Принудительно создаем таблицы для основных станков
    await _createTableForMachine(db, 'FANUC 0i-tf plus (sowin)');
    await _createTableForMachine(db, 'TRAUB (TX8H)');
    await _createTableForMachine(db, 'SYNTEC 22TB (blin)');

    if (kDebugMode) {
      print('Все таблицы проверены/созданы');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    if (kDebugMode) {
      print('Создание таблиц базы данных версии $version');
    }

    try {
      // Создаем таблицы для основных станков
      await _createTableForMachine(db, 'FANUC 0i-tf plus (sowin)');
      await _createTableForMachine(db, 'TRAUB (TX8H)');
      await _createTableForMachine(db, 'SYNTEC 22TB (blin)');

      if (kDebugMode) {
        print('Все таблицы успешно созданы');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Критическая ошибка при создании таблиц: $e');
      }
      // Перебрасываем исключение - важно прервать создание БД при ошибках схемы
      rethrow;
    }
  }

  Future<void> _createTableForMachine(Database db, String machine) async {
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

    if (kDebugMode) {
      print('Таблица $tableName создана/проверена');
    }
  }

  // Загрузка данных из JSON
  Future<void> loadInitialSelData({String? machine, String? nameCode}) async {
    try {
      final db = await database;

      // Проверяем, есть ли уже данные в базе
      // final hasData = await _checkIfDataExists(db, machine, nameCode);
      // if (hasData) {
      //   if (kDebugMode) {
      //     print('Данные уже существуют в базе, пропускаем загрузку');
      //   }
      //   _isInitialized = true;
      //   return;
      // }

      final String jsonString = await rootBundle.loadString(
        'assets/data/operations.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> operationsJson = jsonData['operations'];

      // Фильтруем операции по machine и nameCode
      final List<dynamic> filteredOperations = operationsJson.where((
        operationJson,
      ) {
        final opMachine = operationJson['machine']?.toString() ?? '';
        final opNameCode = operationJson['nameCode']?.toString() ?? '';

        // Если оба параметра null, загружаем все
        if (machine == null && nameCode == null) {
          return true;
        }
        // Если указан только machine
        else if (machine != null && nameCode == null) {
          return opMachine == machine;
        }
        // Если указан только nameCode
        else if (machine == null && nameCode != null) {
          return opNameCode == nameCode;
        }
        // Если указаны оба параметра
        else {
          return opMachine == machine && opNameCode == nameCode;
        }
      }).toList();

      if (filteredOperations.isEmpty) {
        if (kDebugMode) {
          print(
            'Нет данных для загрузки с параметрами: machine=$machine, nameCode=$nameCode',
          );
        }
        return;
      }

      int loadedCount = 0;
      for (final operationJson in filteredOperations) {
        // Используем фабричный метод fromJson для безопасного создания объекта
        final operation = Operation.fromJson(operationJson);

        final tableName = _getTableName(operation.machine);
        await db.insert(
          tableName,
          operation.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        loadedCount++;
      }

      if (kDebugMode) {
        print(
          'Загружено $loadedCount операций из JSON (machine: $machine, nameCode: $nameCode)',
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Ошибка загрузки данных из JSON: $e');
        print('Stack trace: $stackTrace');
      }
      rethrow;
    }
  }

  Future<void> loadInitialData({String? machine, String? nameCode}) async {
    if (_isInitialized) return;
    try {
      final db = await database;
      // УБЕДИТЕСЬ, что таблицы созданы перед загрузкой данных !!!!!!!!!!!!!!!!!!убрал, посмортим
      // await ensureTablesCreated();
      // Даем время на создание таблиц
      // await Future.delayed(const Duration(milliseconds: 500));

      // Проверяем, есть ли уже данные в базе
      final hasData = await _checkIfDataExists(db, machine, nameCode);
      if (hasData) {
        if (kDebugMode) {
          print('Данные уже существуют в базе, пропускаем загрузку');
        }
        _isInitialized = true;
        return;
      }

      final String jsonString = await rootBundle.loadString(
        'assets/data/operations.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> operationsJson = jsonData['operations'];

      // Фильтруем операции по machine и nameCode
      final List<dynamic> filteredOperations = operationsJson.where((
        operationJson,
      ) {
        final opMachine = operationJson['machine']?.toString() ?? '';
        final opNameCode = operationJson['nameCode']?.toString() ?? '';

        // Если оба параметра null, загружаем все
        if (machine == null && nameCode == null) {
          return true;
        }
        // Если указан только machine
        else if (machine != null && nameCode == null) {
          return opMachine == machine;
        }
        // Если указан только nameCode
        else if (machine == null && nameCode != null) {
          return opNameCode == nameCode;
        }
        // Если указаны оба параметра
        else {
          return opMachine == machine && opNameCode == nameCode;
        }
      }).toList();

      if (filteredOperations.isEmpty) {
        if (kDebugMode) {
          print(
            'Нет данных для загрузки с параметрами: machine=$machine, nameCode=$nameCode',
          );
        }
        return;
      }

      int loadedCount = 0;
      for (final operationJson in filteredOperations) {
        // Используем фабричный метод fromJson для безопасного создания объекта
        final operation = Operation.fromJson(operationJson);

        final tableName = _getTableName(operation.machine);
        await db.insert(
          tableName,
          operation.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        loadedCount++;
      }

      if (kDebugMode) {
        print(
          'Загружено $loadedCount операций из JSON (machine: $machine, nameCode: $nameCode)',
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Ошибка загрузки данных из JSON: $e');
        print('Stack trace: $stackTrace');
      }
      rethrow;
    }
  }

  // Проверяем, есть ли данные в базе  !!!!изменил
  Future<bool> _checkIfDataExists(
    Database db,
    String? machine,
    String? nameCode,
  ) async {
    try {
      final tableName = _getTableName(machine);

      // Проверяем существование таблицы
      final tableExists = await _tableExists(db, tableName);
      if (!tableExists) {
        if (kDebugMode) {
          print('Таблицы с таким названием не существует $tableName');
        }
      }

      if (kDebugMode) {
        print('$machine,$nameCode,$tableName');
      }

      final count =
          Sqflite.firstIntValue(
            await db.query(
              tableName,
              where: '$columnMachine = ? AND $columnNameCode = ?',
              whereArgs: [tableName, nameCode],
            ),
          ) ??
          0;

      if (kDebugMode) {
        print('Count in $tableName: $count');
      }
      if (count > 0) {
        return true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if data exists: $e');
      }
      return false;
    }
  }

  // Добавьте этот метод для проверки существования таблицы
  Future<bool> _tableExists(Database db, String tableName) async {
    try {
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Создает таблицу для станка, если её нет
  Future<void> createTableIfNotExists(String machine) async {
    final db = await database;
    await _createTableForMachine(db, machine);
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // CRUD операции с указанием станка
  Future<int> insertOperation(Operation operation) async {
    final db = await database;
    final tableName = _getTableName(operation.machine);

    // Создаем таблицу, если её нет
    await createTableIfNotExists(operation.machine);

    return await db.insert(
      tableName,
      operation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Operation>> getAllOperations(
    String? machine,
    String? nameCode,
  ) async {
    final db = await database;
    final tableName = _getTableName(machine);

    if (nameCode == null) {
      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: '$columnMachine = ?',
        whereArgs: [machine],
      );
      final sortedData = List<Map<String, dynamic>>.from(maps);
      sortedData.sort((a, b) {
        final valueA = a[columnCode]?.toString() ?? '';
        final valueB = b[columnCode]?.toString() ?? '';
        final numA = _extractNumber(valueA);
        final numB = _extractNumber(valueB);
        final numericCompare = numA.compareTo(numB);
        if (numericCompare == 0) {
          return valueA.compareTo(valueB);
        }
        return numericCompare;
      });
      return List.generate(
        sortedData.length,
        (i) => Operation.fromMap(sortedData[i]),
      );
    } else {
      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: '$columnMachine = ? AND $columnNameCode = ?',
        whereArgs: [machine, nameCode],
      );
      final sortedData = List<Map<String, dynamic>>.from(maps);
      sortedData.sort((a, b) {
        final valueA = a[columnCode]?.toString() ?? '';
        final valueB = b[columnCode]?.toString() ?? '';
        final numA = _extractNumber(valueA);
        final numB = _extractNumber(valueB);
        final numericCompare = numA.compareTo(numB);
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
  }

  Future<List<Operation>> getAllOperationsFromMashin({String? machine}) async {
    final db = await database;
    final tableName = _getTableName(machine);
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnMachine = ?',
      whereArgs: [machine],
    );
    final sortedData = List<Map<String, dynamic>>.from(maps);
    sortedData.sort((a, b) {
      final valueA = a[columnCode]?.toString() ?? '';
      final valueB = b[columnCode]?.toString() ?? '';
      final numA = _extractNumber(valueA);
      final numB = _extractNumber(valueB);
      final numericCompare = numA.compareTo(numB);
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

  int _extractNumber(String value) {
    try {
      final numbersOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
      return int.tryParse(numbersOnly) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<Operation>> getAllGkodTraubOperations() async {
    return await getAllOperations('TRAUB (TX8H)', 'G - kod');
  }

  Future<List<Operation>> getAllOperationsByNotes(String machine) async {
    final db = await database;
    final tableName = _getTableName(machine);

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where:
          '$columnMachine = ? AND ($columnNote != ? AND $columnNote != ? OR $columnImages != ? AND $columnImages != ?)',
      whereArgs: [machine, "", 'null', "", 'null'],
    );
    //================          сортировка
    final sortedData = List<Map<String, dynamic>>.from(maps);
    sortedData.sort((a, b) {
      final valueA = a[columnCode]?.toString() ?? '';
      final valueB = b[columnCode]?.toString() ?? '';
      final numA = _extractNumber(valueA);
      final numB = _extractNumber(valueB);
      final numericCompare = numA.compareTo(numB);
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

  Future<Operation?> getOperation(String machine, String code) async {
    final db = await database;
    final tableName = _getTableName(machine);

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnCode = ?',
      whereArgs: [code],
    );
    return maps.isNotEmpty ? Operation.fromMap(maps.first) : null;
  }

  Future<int> updateOperation(Operation operation) async {
    final db = await database;
    final tableName = _getTableName(operation.machine);

    return await db.update(
      tableName,
      operation.toMap(),
      where: '$columnCode = ? AND $columnMachine = ?',
      whereArgs: [operation.code, operation.machine],
    );
  }

  Future<int> deleteOperation(String machine, String code) async {
    final db = await database;
    final tableName = _getTableName(machine);

    return await db.delete(
      tableName,
      where: '$columnCode = ? AND $columnMachine = ?',
      whereArgs: [code, machine],
    );
  }

  Future<int> deleteAllOperation(String machine, String nameCode) async {
    final db = await database;
    final tableName = _getTableName(machine);

    return await db.delete(
      tableName,
      where: '$columnMachine = ? AND $columnNameCode = ?',
      whereArgs: [machine, nameCode],
    );
  }

  // Получить список всех станков, для которых есть таблицы
  Future<List<String>> getAllMachines() async {
    final db = await database;
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'operations_%'",
    );

    return tables.map((table) {
      final tableName = table['name'] as String;
      // Извлекаем оригинальное имя станка из имени таблицы
      return tableName.replaceFirst('operations_', '').replaceAll('_', ' ');
    }).toList();
  }

  // Удалить таблицу для конкретного станка
  Future<void> dropMachineTable(String machine) async {
    final db = await database;
    final tableName = _getTableName(machine);
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
