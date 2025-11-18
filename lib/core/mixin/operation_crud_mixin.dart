// import 'package:flutter/material.dart';
// import 'package:test2/models/operation_model.dart';
// import 'package:test2/services/operation_service.dart';

// mixin OperationMixinCrud<T extends StatefulWidget> on State<T> {
//   // Общие переменные
//   late OperationService operationService;
//   List<Operation> operations = [];
//   bool isLoading = true;
//   bool hasError = false;
//   bool isNotes = false;
//   String errorMessage = '';
//   String searchQuery = '';

//   // Общие методы
//   Future<void> loadOperations(String machine, String nameCode) async {
//     try {
//       final loadedOperations = await operationService.getAllOperations(
//         machine,
//         nameCode,
//       );
//       setState(() {
//         operations = loadedOperations;
//         isLoading = false;
//         hasError = false;
//       });
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         errorMessage = 'Ошибка загрузки данных: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> loadOperationsNotes(String machine) async {
//     try {
//       final loadedOperations = await operationService.getAllNotesOperations(machine);
//       setState(() {
//         operations = loadedOperations;
//         isLoading = false;
//         hasError = false;
//       });
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         errorMessage = 'Ошибка загрузки данных: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> addOperation({
//     required Operation operation,
//     required String machine,
//     required String nameCode,
//   }) async {
//     final success = await operationService.addOperation(operation);
//     if (success) {
//       await loadOperations(machine, nameCode);
//       showSnackBar('Операция добавлена');
//     } else {
//       showSnackBar('Ошибка при добавлении операции');
//     }
//   }

//   Future<void> editOperation({
//     required Operation operation,
//     required String machine,
//     required String nameCode,
//   }) async {
//     final success = await operationService.updateOperation(operation);
//     if (success) {
//       await loadOperations(machine, nameCode);
//       showSnackBar('Операция обновлена');
//     } else {
//       showSnackBar('Ошибка при обновлении операции');
//     }
//   }

//   Future<void> deleteOperation({
//     required Operation operation,
//     required String machine,
//     required String nameCode,
//   }) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Подтверждение удаления'),
//         content: Text('Удалить операцию "${operation.code}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Отмена'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Удалить', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       final success = await operationService.deleteOperation(operation.code);
//       if (success) {
//         await loadOperations(machine, nameCode);
//         showSnackBar('Операция удалена');
//       } else {
//         showSnackBar('Ошибка при удалении операции');
//       }
//     }
//   }

//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
//     );
//   }

 
// }