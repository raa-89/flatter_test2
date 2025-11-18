import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test2/models/operation_model.dart';
import 'package:test2/services/operation_service.dart';
import 'package:test2/widgets/add_operation_dialog.dart';
import 'package:test2/widgets/operation_list_tile.dart';

mixin OperationMixin<T extends StatefulWidget> on State<T> {
  // Общие переменные
  late String machine;
  late String nameCode;
  final OperationService operationService = OperationService();
  List<Operation> operations = [];
  bool isLoading = true;
  bool hasError = false;
  bool isNotes = false;
  String errorMessage = '';
  String searchQuery = '';

  // Общие методы

  void kolbeckData(int pages) {
    setState(() {
      if (pages == 1) {
        nameCode = 'G - kod';
        isNotes = false;
        loadOperations(machine, nameCode);
      } else if (pages == 2) {
        nameCode = 'M - kod';
        isNotes = false;
        loadOperations(machine, nameCode);
      } else {
        nameCode = 'Macros';
        isNotes = true;
        loadOperationsNotes(machine);
      }
      if (kDebugMode) {
        print(nameCode);
      }
    });
  }

  Future<void> initializeApp() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
      });

      await operationService.initializeSampleData(
        machine: machine,
        nameCode: nameCode,
      );
      await loadOperations(machine, nameCode);
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Ошибка инициализации: $e';
        isLoading = false;
      });
      if (kDebugMode) {
        print('Ошибка инициализации: $e');
      }
    }
  }

  Future<void> reloadApp() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтверждение обнуления списка'),
        content: const Text('Вернуть всё к первоночальному списку?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Обнулить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        setState(() {
          isLoading = true;
          hasError = false;
        });

        await operationService.reloadSampleData(machine, nameCode);
        await loadOperations(machine, nameCode);
      } catch (e) {
        setState(() {
          hasError = true;
          errorMessage = 'Ошибка инициализации: $e';
          isLoading = false;
        });
        if (kDebugMode) {
          print('Error initializing app: $e');
        }
      }
    }
  }

  @protected
  Future<void> loadOperations(String machine, String nameCode) async {
    try {
      if (kDebugMode) {
        print('Загрузка операций: machine=$machine, nameCode=$nameCode');
      }
      final loadedOperations = await operationService.getAllOperations(
        machine,
        nameCode,
      );
      if (kDebugMode) {
        print('Загружено операций: ${loadedOperations.length}');
      }
      setState(() {
        operations = loadedOperations;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Ошибка загрузки данных: $e';
        isLoading = false;
      });
    }
  }

  Future<void> loadOperationsNotes(String machine) async {
    try {
      if (kDebugMode) {
        print('Загрузка операций: machine=$machine, nameCode=$nameCode');
      }
      final loadedOperations = await operationService.getAllNotesOperations(
        machine,
      );
      if (kDebugMode) {
        print('Загружено операций: ${loadedOperations.length}');
      }
      setState(() {
        operations = loadedOperations;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Ошибка загрузки данных: $e';
        isLoading = false;
      });
    }
  }

  Future<void> addOperation() async {
    final result = await Navigator.push<Operation>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddOperationDialog(machine: machine, nameCode: nameCode),
      ),
    );

    if (result != null) {
      final success = await operationService.addOperation(result);
      if (success) {
        await loadOperations(machine, nameCode);
        showSnackBar('Операция добавлена');
      } else {
        showSnackBar('Ошибка при добавлении операции');
      }
    }
  }

  Future<void> updateOperationList() async {
    try {
      final loadedOperations = nameCode == "Macros"
          ? await operationService.getAllNotesOperations(machine)
          : await operationService.getAllOperations(machine, nameCode);

      if (kDebugMode) {
        print('$machine,$nameCode, ${loadedOperations.length}');
      }
      setState(() {
        operations = loadedOperations;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Ошибка загрузки данных: $e';
        isLoading = false;
      });
    }
  }

  Future<void> editOperation({required Operation operation}) async {
    final result = await Navigator.push<Operation>(
      context,
      MaterialPageRoute(
        builder: (context) => AddOperationDialog(
          operation: operation,
          machine: machine,
          nameCode: nameCode,
        ),
      ),
    );

    if (result != null) {
      final success = await operationService.updateOperation(result);
      if (success) {
        await loadOperations(machine, nameCode);
        showSnackBar('Операция обновлена');
      } else {
        showSnackBar('Ошибка при обновлении операции');
      }
    }
  }

  Future<void> deleteOperation({required Operation operation}) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтверждение удаления'),
        content: Text('Удалить операцию "${operation.code}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await operationService.deleteOperation(
        operation.machine, // Передаем machine для идентификации таблицы
        operation.code,
      );
      if (success) {
        await loadOperations(machine, nameCode);
        showSnackBar('Операция удалена');
      } else {
        showSnackBar('Ошибка при удалении операции');
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  List<Operation> get filteredOperations {
    if (searchQuery.isEmpty) {
      return operations;
    }
    return operations.where((operation) {
      return operation.code.toLowerCase().contains(searchQuery.toLowerCase()) ||
          operation.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          operation.notes.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  // Виджеты для переиспользования
  Widget buildErrorWidget(VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Произошла ошибка',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Загрузка данных...'),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Поиск',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  Widget NewFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: FloatingActionButton(
        onPressed: addOperation,
        tooltip: 'Добавить операцию',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildOperationsList({bool isNotes = false}) {
    return filteredOperations.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inbox, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  searchQuery.isEmpty ? 'Нет операций' : 'Ничего не найдено',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: filteredOperations.length,
            itemBuilder: (context, index) {
              final operation = filteredOperations[index];
              return OperationListTile(
                operation: operation,
                onEdit: () => editOperation(operation: operation),
                onDelete: () => deleteOperation(operation: operation),
                isNotes: isNotes,
              );
            },
          );
  }
}
