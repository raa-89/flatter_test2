import 'package:flutter/material.dart';
import '../models/operation_model.dart';

class AddOperationDialog extends StatefulWidget {
  final Operation? operation;
  final String machine;
  final String nameCode;
  final bool isEditing;

  const AddOperationDialog({
    super.key,
    this.operation,
    required this.machine,
    required this.nameCode,
  }) : isEditing = operation != null;

  @override
  // ignore: library_private_types_in_public_api
  _AddOperationDialogState createState() => _AddOperationDialogState();
}

class _AddOperationDialogState extends State<AddOperationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  late final String _images = widget.operation?.images ?? '';

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _codeController.text = widget.operation!.code;
      _nameController.text = widget.operation!.name;
      _notesController.text = widget.operation!.notes;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final operation = Operation(
        code: _codeController.text.trim(),
        name: _nameController.text.trim(),
        notes: _notesController.text.trim(),
        // id: null,
        machine: widget.machine,
        nameCode: widget.nameCode,
        images: _images,
      );
      Navigator.of(context).pop(operation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: _submit, icon: const Icon(Icons.save)),
        ],
        automaticallyImplyLeading: true,
        title: Text(
          widget.isEditing ? 'Редактировать операцию' : 'Добавить операцию',
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _codeController,
                        decoration: const InputDecoration(
                          labelText: 'Код операции',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: widget.isEditing,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите код операции';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Название операции',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите название операции';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Примечание',
                          border: OutlineInputBorder(),
                        ),
                        minLines: 3,
                        maxLines: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
