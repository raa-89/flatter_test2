// ignore: file_names
import 'package:flutter/material.dart';

class Popupmenu extends StatefulWidget {
  const Popupmenu({super.key});

  @override
  State<Popupmenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<Popupmenu> {
  @override
  void initState() {
    //инициализация переменых
    super.initState();
    // String value = 'ff';
  }

  @override
  void dispose() {
    // Очистка ресурсов
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //построение изменяемого виджета
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(child: Text('data')),
      ],
    );
  }
}
