import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test2/const.dart';

import '../models/operation_model.dart';
import '../database/database_helper.dart';

class OperationService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Добавляем метод для инициализации базы данных
  Future<void> initializeDatabase() async {
    try {
      // Просто обращаемся к базе данных, чтобы инициализировать её
      await _databaseHelper.database;
      if (kDebugMode) {
        print('База данных успешно проинициализированна');
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

  Future<bool> deleteOperation(String code) async {
    try {
      await _databaseHelper.deleteOperation(code);
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

      // Фильтруем только нужные операции один раз
      final List<Operation> filteredOperations = sampleOperations
          .where((op) => op.machine == machine && op.nameCode == nameCode)
          .toList();

      if (filteredOperations.isEmpty) return;

      final db = await _databaseHelper.database;

      // === КЛЮЧЕВАЯ ЧАСТЬ: вставка большими батчами в одной транзакции ===
      const int batchSize = 500; // оптимально: 300–800 записей за батч
      final int total = filteredOperations.length;

      await db.transaction((txn) async {
        for (int i = 0; i < total; i += batchSize) {
          final batch = txn.batch();

          final end = (i + batchSize) > total ? total : i + batchSize;
          for (int j = i; j < end; j++) {
            batch.insert(
              DatabaseHelper.tableOperations,
              filteredOperations[j].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }

          // Самый быстрый режим — не возвращаем inserted id
          await batch.commit(noResult: true);

          if (kDebugMode) {
            print('Загружено ${end.clamp(0, total)} из $total');
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
// Future<void> initializeSampleData({
//     required String machine,
//     required String nameCode,
//   }) async {
//     try {
//       await initializeDatabase(); // Сначала инициализируем базу данных

//       final operations = await getAllOperations(machine, nameCode);
//       if (operations.isEmpty) {
//         // Фильтруем только нужные операции
//         final filteredOperations = sampleOperations
//             .where((op) => op.machine == machine)
//             // .where((op) => op.machine == machine && op.nameCode == nameCode)
//             .toList();

//         // Разбиваем на пакеты по 50-100 записей
//         // const batchSize = 20;
//         // for (var i = 0; i < filteredOperations.length; i += batchSize) {
//         //   final end = (i + batchSize) < filteredOperations.length
//         //       ? i + batchSize
//         //       : filteredOperations.length;
//         //   final batch = filteredOperations.sublist(i, end);

//         //   for (final operation in batch) {
//         //     await addOperation(operation);
//         //   }
//         //   if (kDebugMode) {
//         //     print(batch.length);
//         //   }

//         //   // Небольшая пауза между пакетами
//         //   await Future.delayed(const Duration(milliseconds: 10));
//         // }

//         for (final operation in filteredOperations) {
//           await addOperation(operation);
//         }
//         if (kDebugMode) {
//           print(
//             'Базовая база данных успешно загружена по $machine $nameCode, количество операций ${sampleOperations.length}',
//           );
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Ошибка загрузки стандартной базы данных: $e');
//       }
//     }
//   }
  Future<void> reloadSampleData(String machine, String nameCode) async {
    try {
      await initializeDatabase(); // Сначала инициализируем базу данных
      await deleteAllOperation(machine, nameCode); // Затем всё удаляем
      await initializeSampleData(
        machine: machine,
        nameCode: nameCode,
      ); // Затем всё создаём заново
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка обновления стандартной базы данных: $e');
      }
    }
  }
}
