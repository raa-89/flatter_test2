import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test2/const.dart';

import '../models/operation_model.dart';
import '../database/database_helper.dart';

class OperationService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> initializeDatabase() async {
    try {
      await _databaseHelper.database;
      if (kDebugMode) {
        print('База данных успешно проинициализированна');
        // Выводим статистику по таблицам
        final stats = await _databaseHelper.getTableStats();
        stats.forEach((machine, count) {
          if (kDebugMode) {
            print('$machine: $count записей');
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing database in service: $e');
      }
      rethrow;
    }
  }

  Future<List<Operation>> getAllOperations(
    String machine,
    String nameCode,
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

  Future<bool> deleteAllSelectedOperation(
    String machine,
    String nameCode,
  ) async {
    try {
      await _databaseHelper.deleteAllSelectedOperation(machine, nameCode);
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
      if (operations.isNotEmpty) {
        if (kDebugMode) print('Данные уже есть ($machine $nameCode), пропускаем инициализацию');
        return;
      }

      // Фильтруем только нужные операции
      final List<Operation> filteredOperations = sampleOperations
          .where((op) => op.machine == machine && op.nameCode == nameCode)
          .toList();

      if (filteredOperations.isEmpty) return;

      final db = await _databaseHelper.database;

      const int batchSize = 500;
      final int total = filteredOperations.length;

      await db.transaction((txn) async {
        for (int i = 0; i < total; i += batchSize) {
          final batch = txn.batch();

          final end = (i + batchSize) > total ? total : i + batchSize;
          for (int j = i; j < end; j++) {
            batch.insert(
              _databaseHelper.getTableNameForMachine(machine),
              filteredOperations[j].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }

          await batch.commit(noResult: true);

          if (kDebugMode) {
            print('Загружено ${end.clamp(0, total)} из $total для $machine');
          }
        }
      });

      if (kDebugMode) {
        print('√ Успешно загружено $total операций для $machine → $nameCode');
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
      await initializeDatabase();
      await deleteAllOperation(machine, nameCode);
      await initializeSampleData(
        machine: machine,
        nameCode: nameCode,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка обновления стандартной базы данных: $e');
      }
    }
  }
}