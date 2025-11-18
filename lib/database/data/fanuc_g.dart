// // ignore_for_file: camel_case_types

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:test2/models/operation_model.dart';
// import 'package:test2/services/operation_service.dart';
// import 'package:test2/widgets/add_operation_dialog.dart';
// import 'package:test2/widgets/operation_list_tile.dart';

// class fanuc_G_kod extends StatefulWidget {
//   const fanuc_G_kod({super.key});

//   @override
//   State<fanuc_G_kod> createState() => _fanuc_G_kodState();
// }

// class _fanuc_G_kodState extends State<fanuc_G_kod> {
//   // List<String> _allLines = [];
//   // List<String> _filteredLines = [];
//   // final TextEditingController _searchController = TextEditingController();
//   // final lines = <String>[
//   //   "G00 Прямо на ускорреном ходу",
//   //   "G01* Подача по прямой/ линейная интерполяция",
//   //   "G02 Круговая интерполяция по часовой стрелке",
//   //   "G03 Круговая интерполяция против часовой стрелки",
//   //   "G04 Время ожидания",
//   //   "G07.1 (G107) Цилиндрическая интерполяция",
//   //   "G09 Точная остановка",
//   //   "G10 Программируемый ввод данных",
//   //   "G12.1 (G112) Интерполяция в полярных координатах ВКЛ.",
//   //   "G13.1 (G113) Интерполяция в полярных координатах ВЫКЛ.",
//   //   "G17 Плоскость фрезерования X-Y",
//   //   "G18 Плоскость фрезерования X-Z",
//   //   "G19 Плоскость фрезерования Y-Z",
//   //   "G20 Выбор программирования в дюймах",
//   //   "G21 Выбор программирования в мм",
//   //   "G28 Подвод к точке начала отсчёта",
//   //   "G32 Нарезание резьбы c постоянным шагом",
//   //   "G34 Нарезание резьбы с переменным шагом",
//   //   "G40 Компенсация радиуса режущей кромки выключена",
//   //   "G41 Компенсация радиуса резца или фрезы включена, инструмент слева от контура ",
//   //   "G42 Компенсация радиуса резца или фрезы включена, инструмент справа от контура",
//   //   "G50 Смещение СК/ задание ограничения частоты вращения шпинделя",
//   //   "G50.2 (G250) Обработка полигона ВЫКЛ.",
//   //   "G51.2 (G251) Обработка полигона ВКЛ.",
//   //   "G65 Вызов макропрограммы",
//   //   "G66 Макро режим ВКЛ",
//   //   "G67 Макро режим ВЫКЛ",
//   //   "G70 Цикл прецизионной обработки",
//   //   "G71 Цикл черновой наружной обработки",
//   //   "G72 Цикл чистовой обработки/ торцевания",
//   //   "G73 Цикл черновой обработки – параллельно контуру",
//   //   "G74 Цикл черновой обработки с прерывистым резанием – продольно",
//   //   "G75 Цикл черновой обработки с прерывистым резанием – поперечно",
//   //   "G76 Многопроходный цикл нарезания резьбы ",
//   //   "G80 Отмена цикла сверления",
//   //   "G83 Цикл осевого сверления",
//   //   "G84 Цикл осевого нарезания резьбы",
//   //   "G184 Цикл нарезания резьбы приводным иснтрументом",
//   //   "G87 Циклы радиального сверления",
//   //   "G188 Цикл радиального нарезания резьбы",
//   //   "G90 Цикл НАР/ ВНУТР точения",
//   //   "G92 Цикл нарезания резьбы",
//   //   "G96 Постоянная скорость резания",
//   //   "G97 Отмена постоянного контроля скорости резания",
//   //   "G98 Подача в мм/мин",
//   //   "G99 Подача в мм/оборот",
//   //   "G150 Задание СК (после G300, только для оси Z1)",
//   //   "G266 Задание параметра",
//   //   "G300 Сброс СК (X1, Z1, Y1)",
//   //   "G310 Сброс СК (X2, Z2, Y2)",
//   // ];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _searchController.addListener(_filterLines);
//   //   _filteredLines = lines;
//   // }

//   // void _filterLines() {
//   //   setState(() {
//   //     _allLines = lines;
//   //     _filteredLines = lines;
//   //   });
//   //   final query = _searchController.text.toLowerCase();

//   //   if (query.isEmpty) {
//   //     setState(() {
//   //       _filteredLines = lines;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       _filteredLines = _allLines
//   //           .where((line) => line.toLowerCase().contains(query))
//   //           .toList();
//   //     });
//   //   }
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return BodySearchKod(
//   //     searchController: _searchController,
//   //     filteredLines: _filteredLines,
//   //   );
//   // }
//   final String machine = 'FANUC 0i-tf plus (sowin)';
//   final String nameCode = "G - kod";
//   final OperationService _operationService = OperationService();
//   List<Operation> _operations = [];
//   bool _isLoading = true;
//   bool _hasError = false;
//   String _errorMessage = '';
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _hasError = false;
//       });

//       await _operationService.initializeSampleData(
//         machine: machine,
//         nameCode: nameCode,
//       );
//       await _loadOperations();
//     } catch (e) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = 'Ошибка инициализации: $e';
//         _isLoading = false;
//       });
//       if (kDebugMode) {
//         print('Error initializing app: $e');
//       }
//     }
//   }

//   Future<void> _reloadApp() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Подтверждение обнуления списка'),
//         content: const Text('Вернуть всё к первоночальному списку?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Отмена'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Обнулить', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       try {
//         setState(() {
//           _isLoading = true;
//           _hasError = false;
//         });

//         await _operationService.reloadSampleData(machine, nameCode);
//         await _loadOperations();
//       } catch (e) {
//         setState(() {
//           _hasError = true;
//           _errorMessage = 'Ошибка инициализации: $e';
//           _isLoading = false;
//         });
//         if (kDebugMode) {
//           print('Error initializing app: $e');
//         }
//       }
//       // final success = await _operationService.deleteOperation(operation.code);
//       // if (success) {
//       //   await _loadOperations();
//       //   _showSnackBar('Операция удалена');
//       // } else {
//       //   _showSnackBar('Ошибка при удалении операции');
//       // }
//     }
//   }

//   Future<void> _loadOperations() async {
//     try {
//       final operations = await _operationService.getAllOperations(machine, nameCode);
//       setState(() {
//         _operations = operations;
//         _isLoading = false;
//         _hasError = false;
//       });
//     } catch (e) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = 'Ошибка загрузки данных: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _addOperation() async {
//     // final result = await showDialog<Operation>(
//     //   context: context,
//     //   builder: (context) => AddOperationDialog(),
//     // );
//     final result = await Navigator.push<Operation>(
//       context,
//       MaterialPageRoute(builder: (context) => const AddOperationDialog(machine: machine,)),
//     );

//     if (result != null) {
//       final success = await _operationService.addOperation(result);
//       if (success) {
//         await _loadOperations();
//         _showSnackBar('Операция добавлена');
//       } else {
//         _showSnackBar('Ошибка при добавлении операции');
//       }
//     }
//   }

//   Future<void> _editOperation(Operation operation) async {
//     // final result = await showDialog<Operation>(
//     //   context: context,
//     //   builder: (context) => AddOperationDialog(operation: operation),
//     // );

//     final result = await Navigator.push<Operation>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddOperationDialog(operation: operation),
//       ),
//     );

//     if (result != null) {
//       final success = await _operationService.updateOperation(result);
//       if (success) {
//         await _loadOperations();
//         _showSnackBar('Операция обновлена');
//       } else {
//         _showSnackBar('Ошибка при обновлении операции');
//       }
//     }
//   }

//   Future<void> _deleteOperation(Operation operation) async {
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
//       final success = await _operationService.deleteOperation(operation.code);
//       if (success) {
//         await _loadOperations();
//         _showSnackBar('Операция удалена');
//       } else {
//         _showSnackBar('Ошибка при удалении операции');
//       }
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
//     );
//   }

//   List<Operation> get _filteredOperations {
//     if (_searchQuery.isEmpty) {
//       return _operations;
//     }
//     return _operations.where((operation) {
//       return operation.code.toLowerCase().contains(
//             _searchQuery.toLowerCase(),
//           ) ||
//           operation.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//           operation.notes.toLowerCase().contains(_searchQuery.toLowerCase());
//     }).toList();
//   }

//   Widget _buildErrorWidget() {
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
//               _errorMessage,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _initializeApp,
//             child: const Text('Попробовать снова'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingWidget() {
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

//   Widget _buildContent() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: TextField(
//             decoration: const InputDecoration(
//               labelText: 'Поиск',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) {
//               setState(() {
//                 _searchQuery = value;
//               });
//             },
//           ),
//         ),
//         Expanded(
//           child: _filteredOperations.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.inbox, size: 64, color: Colors.grey),
//                       const SizedBox(height: 16),
//                       Text(
//                         _searchQuery.isEmpty
//                             ? 'Нет операций'
//                             : 'Ничего не найдено',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: _filteredOperations.length,
//                   itemBuilder: (context, index) {
//                     final operation = _filteredOperations[index];
//                     return OperationListTile(
//                       operation: operation,
//                       onEdit: () => _editOperation(operation),
//                       onDelete: () => _deleteOperation(operation),
//                       isNotes: false,
//                     );
//                   },
//                   // separatorBuilder: (BuildContext context, int index) {
//                   //   return Padding(
//                   //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   //     child: Divider(height: 1.0, color: Colors.black),
//                   //   );
//                   // },
//                 ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Операции'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             // onPressed: _initializeApp,
//             onPressed: _initializeApp,
//             tooltip: 'Обновить',
//           ),
//           IconButton(
//             icon: const Icon(Icons.repeat),
//             // onPressed: _initializeApp,
//             onPressed: _reloadApp,
//             tooltip: 'Вернуть в первоночальный вид',
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? _buildLoadingWidget()
//           : _hasError
//           ? _buildErrorWidget()
//           : _buildContent(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addOperation,
//         tooltip: 'Добавить операцию',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
