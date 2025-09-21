// ignore: file_names
import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';

class BodySearchKod extends StatelessWidget {
  const BodySearchKod({
    super.key,
    required TextEditingController searchController,
    required List<String> filteredLines,
  }) : _searchController = searchController,
       _filteredLines = filteredLines;

  final TextEditingController _searchController;
  final List<String> _filteredLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Поисковая строка
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              hintText: 'Введите текст для поиска...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        // Разделитель
        Divider(),

        // Список строк
        Expanded(
          child: ListView.separated(
            itemCount: _filteredLines.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _filteredLines[index],
                  style: TextStyle(fontSize: fontSizeBody),
                ),
                /* leading: CircleAvatar(child: Text('${index + 1}')), */
              );
            },
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 1.0, color: colorDivider),
            ),
          ),
        ),
      ],
    );
  }
}
