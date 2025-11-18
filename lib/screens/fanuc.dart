// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:test2/core/mixin/base_operation_mixin.dart';
import 'package:test2/screens/DrawerScreen.dart';
import 'package:test2/widgets/buttonNavigation.dart';
import 'package:test2/const.dart';

class BodyFanuc extends StatefulWidget {
  const BodyFanuc({super.key});

  @override
  State<BodyFanuc> createState() => BodyFanucState();
}

class BodyFanucState extends State<BodyFanuc> with OperationMixin<BodyFanuc> {
  // ignore: unused_field
  double _startDragX = 0.0;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int pages = 1;
  // Widget widgetBody = const fanuc_G_kod();
  static late Object titleFromDrawer;

  @override
  String machine = "FANUC 0i-tf plus (sowin)";
  @override
  String nameCode = "G - kod";
  // final OperationService _operationService = OperationService();
  // List<Operation> _operations = [];
  // bool _isLoading = true;
  // bool _hasError = false;
  // bool _isNotes = false;
  // String _errorMessage = '';
  // String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = drawerOpenXOffset;
      yOffset = drawerOpenYOffset;
      isDrawerOpen = true;
    });
  }

  // void kolbeckData(int pages) {
  //   setState(() {
  //     if (pages == 1) {
  //       nameCode = 'G - kod';
  //       _isNotes = false;
  //       _loadOperations(machine, nameCode);
  //     } else if (pages == 2) {
  //       nameCode = 'M - kod';
  //       _isNotes = false;
  //       _loadOperations(machine, nameCode);
  //     } else {
  //       nameCode = 'Macros';
  //       _isNotes = true;
  //       _loadOperationsNotes(machine);
  //     }
  //     if (kDebugMode) {
  //       print(nameCode);
  //     }
  //   });
  // }

  // Future<void> initializeApp() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //       hasError = false;
  //     });

  //     await operationService.initializeSampleData(
  //       machine: machine,
  //       nameCode: nameCode,
  //     );
  //     await loadOperations(machine, nameCode);
  //   } catch (e) {
  //     setState(() {
  //       hasError = true;
  //       errorMessage = 'Ошибка инициализации: $e';
  //       isLoading = false;
  //     });
  //     if (kDebugMode) {
  //       print('Error initializing app: $e');
  //     }
  //   }
  // }

  // Future<void> _reloadApp() async {
  //   final confirmed = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Подтверждение обнуления списка'),
  //       content: const Text('Вернуть всё к первоночальному списку?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text('Отмена'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text('Обнулить', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (confirmed == true) {
  //     try {
  //       setState(() {
  //         _isLoading = true;
  //         _hasError = false;
  //       });

  //       await _operationService.reloadSampleData(machine, nameCode);
  //       await _loadOperations(machine, nameCode);
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
  //     // final success = await _operationService.deleteOperation(operation.code);
  //     // if (success) {
  //     //   await _loadOperations();
  //     //   _showSnackBar('Операция удалена');
  //     // } else {
  //     //   _showSnackBar('Ошибка при удалении операции');
  //     // }
  //   }
  // }

  // Future<void> _loadOperations(String machine, String nameCode) async {
  //   try {
  //     final operations = await _operationService.getAllOperations(
  //       machine,
  //       nameCode,
  //     );
  //     setState(() {
  //       _operations = operations;
  //       _isLoading = false;
  //       _hasError = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _hasError = true;
  //       _errorMessage = 'Ошибка загрузки данных: $e';
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _loadOperationsNotes(String machine) async {
  //   try {
  //     final operations = await _operationService.getAllNotesOperations(machine);
  //     setState(() {
  //       _operations = operations;
  //       _isLoading = false;
  //       _hasError = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _hasError = true;
  //       _errorMessage = 'Ошибка загрузки данных: $e';
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _addOperation() async {
  //   // final result = await showDialog<Operation>(
  //   //   context: context,
  //   //   builder: (context) => AddOperationDialog(),
  //   // );
  //   final result = await Navigator.push<Operation>(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           AddOperationDialog(machine: machine, nameCode: nameCode),
  //     ),
  //   );

  //   if (result != null) {
  //     final success = await _operationService.addOperation(result);
  //     if (success) {
  //       await _loadOperations(machine, nameCode);
  //       _showSnackBar('Операция добавлена');
  //     } else {
  //       _showSnackBar('Ошибка при добавлении операции');
  //     }
  //   }
  // }

  // Future<void> _editOperation(Operation operation) async {
  //   // final result = await showDialog<Operation>(
  //   //   context: context,
  //   //   builder: (context) => AddOperationDialog(operation: operation),
  //   // );

  //   final result = await Navigator.push<Operation>(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AddOperationDialog(
  //         operation: operation,
  //         machine: machine,
  //         nameCode: nameCode,
  //       ),
  //     ),
  //   );

  //   if (result != null) {
  //     final success = await _operationService.updateOperation(result);
  //     if (success) {
  //       await _loadOperations(machine, nameCode);
  //       _showSnackBar('Операция обновлена');
  //     } else {
  //       _showSnackBar('Ошибка при обновлении операции');
  //     }
  //   }
  // }

  // Future<void> _deleteOperation(Operation operation) async {
  //   final confirmed = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Подтверждение удаления'),
  //       content: Text('Удалить операцию "${operation.code}"?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text('Отмена'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text('Удалить', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (confirmed == true) {
  //     final success = await _operationService.deleteOperation(operation.code);
  //     if (success) {
  //       await _loadOperations(machine, nameCode);
  //       _showSnackBar('Операция удалена');
  //     } else {
  //       _showSnackBar('Ошибка при удалении операции');
  //     }
  //   }
  // }

  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  //   );
  // }

  // List<Operation> get _filteredOperations {
  //   if (_searchQuery.isEmpty) {
  //     return _operations;
  //   }
  //   return _operations.where((operation) {
  //     return operation.code.toLowerCase().contains(
  //           _searchQuery.toLowerCase(),
  //         ) ||
  //         operation.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
  //         operation.notes.toLowerCase().contains(_searchQuery.toLowerCase());
  //   }).toList();
  // }

  // Widget _buildErrorWidget() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Icon(Icons.error_outline, size: 64, color: Colors.red),
  //         const SizedBox(height: 16),
  //         const Text(
  //           'Произошла ошибка',
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(height: 8),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 32),
  //           child: Text(
  //             _errorMessage,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(fontSize: 14),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         ElevatedButton(
  //           onPressed: _initializeApp,
  //           child: const Text('Попробовать снова'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildLoadingWidget() {
  //   return const Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CircularProgressIndicator(),
  //         SizedBox(height: 16),
  //         Text('Загрузка данных...'),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildContent() {
    return Column(
      children: [
        buildSearchField(),
        Expanded(
          child: buildOperationsList(isNotes: isNotes),
          // separatorBuilder: (BuildContext context, int index) {
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: Divider(height: 1.0, color: Colors.black),
          //   );
          // },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';
    // machine = titleFromDrawer as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Drawerscreen(drawerClose: closeDrawer),
          SafeArea(
            child: AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                // ignore: deprecated_member_use
                ..scale(isDrawerOpen ? drawerOpenScale : drawerCloseScale)
                ..rotateZ(isDrawerOpen ? drawerOpenRotation : 0),
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(radiusCont)
                    : BorderRadius.circular(0),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: isDrawerOpen ? () => closeDrawer() : null,
                onHorizontalDragStart: (details) =>
                    _startDragX = details.globalPosition.dx,
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > deltaDx) openDrawer();
                  if (details.delta.dx < -deltaDx) closeDrawer();
                },
                child: Column(
                  children: [
                    // Заголовок
                    SizedBox(
                      height: standing_up_to_uppbar,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            isDrawerOpen
                                ? GestureDetector(
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: iconSizeDrawer,
                                    ),
                                    onTap: () => closeDrawer(),
                                  )
                                : GestureDetector(
                                    child: const Icon(
                                      Icons.menu,
                                      size: iconSizeDrawer,
                                    ),
                                    onTap: () => openDrawer(),
                                  ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  titleFromDrawer as String,
                                  style: const TextStyle(
                                    fontSize: fontSizeTitle,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: reloadApp,
                              icon: const Icon(Icons.repeat),
                              tooltip: 'Вернуть в первоночальный вид',
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Основной контент (занимает все доступное пространство)
                    Expanded(
                      child: isLoading
                          ? buildLoadingWidget()
                          : hasError
                          ? buildErrorWidget(initializeApp)
                          : _buildContent(),
                    ),

                    // Нижняя навигация
                    NewButtonNavigation(
                      onDataChanged: kolbeckData,
                      tooltip1: 'G - kod',
                      tooltip2: 'M - kod',
                      tooltip3: 'Makros',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: addOperation,
          tooltip: 'Добавить операцию',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
