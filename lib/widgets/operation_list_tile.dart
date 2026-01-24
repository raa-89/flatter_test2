import 'package:flutter/material.dart';
import 'package:test2/core/const.dart';
import '../models/operation_model.dart';

class OperationListTile extends StatelessWidget {
  final Operation operation;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isNotes;

  const OperationListTile({
    super.key,
    required this.operation,
    required this.onEdit,
    required this.onDelete,
    required this.isNotes,
  });

  @override
  Widget build(BuildContext context) {
    return isNotes
        ? GestureDetector(
            onTap: () => onEdit(),
            onLongPress: () => onDelete(),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: sizedBoxHome,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(cirkulRadiusCont),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: paddingHomeConteiner,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    operation.code,
                    style: const TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Divider(),
                  if (operation.images != "")
                    Center(child: Image.asset(operation.images, height: 200)),
                  const SizedBox(height: sizedBoxHome),
                  NewTextSeparated(data: operation.name),
                  if (operation.notes != "")
                    NewTextSeparated(data: operation.notes),
                ],
              ),
            ),
          )
        : Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            elevation: 2,

            child: ListTile(
              title: Text(
                "${operation.code}  ${operation.name}",
                style: const TextStyle(
                  fontWeight: TextConst.fontWeightBody,
                  fontSize: 16,
                ),
              ),
              onTap: () => onEdit(),
              onLongPress: () => onDelete(),
            ),
          );
  }
}

class NewTextSeparated extends StatelessWidget {
  final String data;
  const NewTextSeparated({super.key, required this.data});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: const TextStyle(
            fontSize: fontSizeBody,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
