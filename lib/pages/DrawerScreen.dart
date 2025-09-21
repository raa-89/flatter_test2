// ignore: file_names
import 'package:flutter/material.dart';
import 'package:test2/pages/routes.dart';

class Drawerscreen extends StatefulWidget {
  const Drawerscreen({super.key});

  @override
  State<Drawerscreen> createState() => _DrawerscreenState();
}

class _DrawerscreenState extends State<Drawerscreen> {
  @override
  void initState() {
    //инициализация переменых
    super.initState();
  }

  @override
  void dispose() {
    // Очистка ресурсов
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //построение изменяемого виджета
    return Container(
      color: Colors.blueGrey[400],
      padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Image.asset('assets/img/kot.jpg'),
                ),
              ),
              SizedBox(width: 10),
              const Text("Рублёв Андрей"),
            ],
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                icon: Icon(Icons.home_outlined, color: Colors.white),
                label: const Text('Домашний экран'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.fanuc);
                },
                icon: Icon(Icons.apps_sharp, color: Colors.white),
                label: const Text('Fanuc'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  AppRoutes.fanuc;
                },
                icon: Icon(Icons.apps_sharp, color: Colors.white),
                label: const Text('Fanuc'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
