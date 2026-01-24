import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/operation_model.dart';
import '../database/database_helper.dart';

class OperationService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isInitialized = false;

  // Добавляем метод для инициализации базы данных
  Future<void> initializeDatabase({String? machine, String? nameCode}) async {
  if (_isInitialized) {
    if (kDebugMode) {
      print('База данных уже инициализирована');
    }
    return;
  }

  try {
    // Инициализируем базу данных
    await _databaseHelper.database;

    // УБЕДИТЕСЬ, что таблицы созданы
    await _databaseHelper.ensureTablesCreated();

    // Увеличиваем задержку для надежности
    // await Future.delayed(const Duration(milliseconds: 1000));

    // Загружаем данные из JSON
    await _databaseHelper.loadInitialData(
      machine: machine,
      nameCode: nameCode,
    );
    
    _isInitialized = true;
    if (kDebugMode) {
      print('База данных успешно проинициализированна и данные загружены');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error initializing database in service: $e');
    }
    rethrow;
  }
}

  Future<List<Operation>> getAllOperations(
    String? machine,
    String? nameCode,
  ) async {
    try {
      return await _databaseHelper.getAllOperations(machine, nameCode);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения кодов: $e');
      }
      return [];
    }
  }

   Future<List<Operation>> getAllOperationsFromMashin(
    String? machine,
  ) async {
    try {
      return await _databaseHelper.getAllOperationsFromMashin(machine:machine);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения кодов: $e');
      }
      return [];
    }
  }

  Future<List<Operation>> getAllTraubOperations() async {
    try {
      return await _databaseHelper.getAllGkodTraubOperations();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения кодов: $e');
      }
      return [];
    }
  }

  Future<List<Operation>> getAllNotesOperations(String machine) async {
    try {
      return await _databaseHelper.getAllOperationsByNotes(machine);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения кодов: $e');
      }
      return [];
    }
  }

  Future<bool> addOperation(Operation operation) async {
    try {
      await _databaseHelper.insertOperation(operation);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка добавления операции: $e');
      }
      return false;
    }
  }

  Future<bool> updateOperation(Operation operation) async {
    try {
      await _databaseHelper.updateOperation(operation);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating operation: $e');
      }
      return false;
    }
  }

  Future<bool> deleteOperation(String machine, String code) async {
    try {
      await _databaseHelper.deleteOperation(machine, code);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка удаления операции $code: $e');
      }
      return false;
    }
  }

  Future<bool> deleteAllOperation(String machine, String nameCode) async {
    try {
      await _databaseHelper.deleteAllOperation(machine, nameCode);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка удаления всех операций по $machine: $e');
      }
      return false;
    }
  }

  

  Future<void> initializeSampleData({
    required String machine,
    required String nameCode,
  }) async {
    try {
      await initializeDatabase();

      final operations = await getAllOperations(machine, nameCode);
      if (kDebugMode) {
        print(
          'Загружено операций для $machine $nameCode: ${operations.length}',
        );
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Ошибка initializeSampleData: $e\n$s');
      }
      rethrow;
    }
  }

  Future<void> reloadSampleData(String machine, String nameCode) async {
    try {
      await initializeDatabase(machine: machine, nameCode: nameCode);
      await deleteAllOperation(machine, nameCode);

      // Перезагружаем данные из JSON
      await _databaseHelper.loadInitialSelData(
        machine: machine,
        nameCode: nameCode,
      );

      if (kDebugMode) {
        print('Данные перезагружены для $machine $nameCode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка обновления стандартной базы данных: $e');
      }
    }
  }
    Future<void> loadInitialSelData({String? machine, String? nameCode}) async {
    try {
      await initializeDatabase(machine: machine, nameCode: nameCode);
      // Перезагружаем данные из JSON
      await _databaseHelper.loadInitialSelData(
        machine: machine,
        nameCode: nameCode,
      );

      if (kDebugMode) {
        print('Данные загружены для $machine $nameCode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка обновления стандартной базы данных: $e');
      }
    }
  }



   // Метод для полной перезагрузки данных (удаление и загрузка заново)
  Future<void> reloadAllData() async {
    try {
      // Сбрасываем флаги
      _isInitialized = false;
      
      // Закрываем текущее соединение с БД
      await _databaseHelper.close();
      
      // Удаляем файл базы данных для полного сброса
      final String databasePath = await getDatabasesPath();
      final String path = join(databasePath, 'operations.db');
      
      // Проверяем существование файла перед удалением
      final databaseFile = File(path);
      if (await databaseFile.exists()) {
        await databaseFile.delete();
        if (kDebugMode) {
          print('Файл базы данных удален');
        }
      }
      
      // Переинициализируем базу данных
      await initializeDatabase();
      
      if (kDebugMode) {
        print('Все данные успешно перезагружены');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка перезагрузки всех данных: $e');
      }
      rethrow;
    }
  }

  
}
