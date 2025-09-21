import 'package:flutter/material.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/data/fanuc_g.dart';
import 'package:test2/pages/data/fanuc_m.dart';
import 'package:test2/pages/data/fanuc_macros.dart';
import 'package:test2/pages/routes.dart';

class BodyFanuc extends StatefulWidget {
  const BodyFanuc({super.key});

  @override
  State<BodyFanuc> createState() => _BodyFanucState();
}

class _BodyFanucState extends State<BodyFanuc> {
  int pages = 1;
  Widget widgetBody = fanuc_G_kod();

  @override
  void initState() {
    //инициализация переменых
    super.initState();
  }

  void kolbeckData(int data) {
    setState(() {
      pages = data;
      if (pages == 1) {
        widgetBody = fanuc_G_kod();
      } else if (pages == 2) {
        widgetBody = Fanuc_M_kod();
      } else {
        widgetBody = FanucMacros();
      }
    });
  }

  @override
  void dispose() {
    // Очистка ресурсов
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //построение изменяемого виджета
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'title from material app',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorApp,
          title: Text('funuc'),
          centerTitle: true,
          leading: Icon(Icons.menu),
        ),
        backgroundColor: Colors.white,
        body: widgetBody,

        /* pages == 1 ? fanuc_G_kod() : Fanuc_M_kod(), */
        bottomNavigationBar: NewButtonNavigation(
          onDataChanged: kolbeckData,
          tooltip1: 'G - kod',
          tooltip2: 'M - kod',
          tooltip3: 'Makros',
          onPressedWidget1: AppRoutes.fanuc,
          onPressedWidget2: AppRoutes.fanuc,
          onPressedWidget3: AppRoutes.home,
        ),
      ),
    );
  }
}

