// import 'package:flutter/material.dart';
// import 'package:test2/models/operation_model.dart';
// import 'package:test2/services/operation_service.dart';
// import 'package:test2/widgets/operation_list_tile.dart';

// typedef OperationCallback = Future<void> Function(Operation operation);

// mixin OperationMixin<T extends StatefulWidget> on State<T> {
//   // Общие переменные
//   late OperationService operationService;
//   List<Operation> operations = [];
//   bool isLoading = true;
//   bool hasError = false;
//   bool isNotes = false;
//   String errorMessage = '';
//   String searchQuery = '';


//   List<Operation> get filteredOperations {
//     if (searchQuery.isEmpty) {
//       return operations;
//     }
//     return operations.where((operation) {
//       return operation.code.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           operation.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           operation.notes.toLowerCase().contains(searchQuery.toLowerCase());
//     }).toList();
//   }

//   Widget buildErrorWidget(VoidCallback onRetry) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 64, color: Colors.red),
//           const SizedBox(height: 16),
//           const Text(
//             'Произошла ошибка',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               errorMessage,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: onRetry,
//             child: const Text('Попробовать снова'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildLoadingWidget() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 16),
//           Text('Загрузка данных...'),
//         ],
//       ),
//     );
//   }

//   Widget buildSearchField() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: TextField(
//         decoration: const InputDecoration(
//           labelText: 'Поиск',
//           prefixIcon: Icon(Icons.search),
//           border: OutlineInputBorder(),
//         ),
//         onChanged: (value) {
//           setState(() {
//             searchQuery = value;
//           });
//         },
//       ),
//     );
//   }

//   Widget buildOperationsList({
//     required List<Operation> operations,
//     required OperationCallback onEdit,
//     required OperationCallback onDelete,
//     bool isNotes = false,
//   }) {
//     return filteredOperations.isEmpty
//         ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.inbox, size: 64, color: Colors.grey),
//                 const SizedBox(height: 16),
//                 Text(
//                   searchQuery.isEmpty ? 'Нет операций' : 'Ничего не найдено',
//                   style: const TextStyle(fontSize: 18, color: Colors.grey),
//                 ),
//               ],
//             ),
//           )
//         : ListView.builder(
//             itemCount: filteredOperations.length,
//             itemBuilder: (context, index) {
//               final operation = filteredOperations[index];
//               return OperationListTile(
//                 operation: operation,
//                 onEdit: () => onEdit(operation),
//                 onDelete: () => onDelete(operation),
//                 isNotes: isNotes,
//               );
//             },
//           );
//   }
// }
