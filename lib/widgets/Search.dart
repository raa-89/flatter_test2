import 'package:flutter/material.dart';
import 'package:test2/const.dart';
// import 'package:test2/pages/editList.dart';

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
            decoration: const InputDecoration(
              labelText: 'Поиск',
              hintText: 'Введите текст для поиска...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        // Разделитель
        const Divider(height: 1),

        // Список строк (занимает все оставшееся пространство)
        Expanded(
          child: Scrollbar(
            trackVisibility: true,
            thickness: thicknessScrollbar,
            radius: const Radius.circular(radiusScrollbar),
            interactive: true,
            child: ListView.separated(
              itemCount: _filteredLines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  enabled: true,
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           Editlist(dataFromList: _filteredLines[index]),
                  //     ),
                  //   );
                  // },
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.arrow_forward_ios_sharp),
                  // ),
                  title: Text(
                    _filteredLines[index],
                    style: const TextStyle(fontSize: fontSizeBody),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(height: 1.0, color: colorDivider),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
