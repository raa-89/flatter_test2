// ignore: file_names
import 'package:flutter/material.dart';

/* class ButtonNavigation {
  static Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.fanucG),
            icon: Text('G'),
            tooltip: 'Fanuc G код',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
            icon: Icon(Icons.home),
            tooltip: 'Главная',
          ),
        ],
      ),
    );
  }
} */

class NewButtonNavigation extends StatefulWidget {
  final String tooltip1;
  final String tooltip2;
  final String tooltip3;
  final String onPressedWidget1;
  final String onPressedWidget2;
  final String onPressedWidget3;

  const NewButtonNavigation({
    super.key,
    required this.tooltip1,
    required this.tooltip2,
    required this.tooltip3,
    required this.onPressedWidget1,
    required this.onPressedWidget2,
    required this.onPressedWidget3,
  });

  @override
  State<NewButtonNavigation> createState() => _NewButtonNavigationState();
}

class _NewButtonNavigationState extends State<NewButtonNavigation> {
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isPressed1 = !isPressed1;
                isPressed2 = false;
                isPressed3 = false;
              });
              Navigator.pushNamed(context, widget.onPressedWidget1);
            },
            icon: Text(
              'G',
              style: TextStyle(color: isPressed1 ? Colors.blue : Colors.black),
            ),
            tooltip: widget.tooltip1,
            isSelected: isPressed1,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                /* isPressed1 = false;
                isPressed2 = !isPressed1;
                isPressed3 = false; */
              });
              Navigator.pushNamed(context, widget.onPressedWidget2);
            },
            icon: Text('M'),
            tooltip: widget.tooltip2,
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, widget.onPressedWidget3),
            icon: Icon(Icons.home),
            tooltip: widget.tooltip3,
          ),
        ],
      ),
    );
  }
}
