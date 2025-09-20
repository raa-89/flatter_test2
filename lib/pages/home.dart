// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/routes.dart';

class homePages extends StatelessWidget {
  const homePages({super.key});

  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorApp,
          title: const Text('Домашний экран'),
          centerTitle: true,
          leading: Icon(Icons.menu),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: HomeBody()),
        bottomNavigationBar: NewButtonNavigation(
          tooltip1: 'G - kod',
          tooltip2: 'M - kod',
          tooltip3: 'Makros',
          onPressedWidget1: AppRoutes.fanucG,
          onPressedWidget2: AppRoutes.fanucG,
          onPressedWidget3: AppRoutes.home,
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: paddingHomeConteiner),
      child: Column(
        children: [
          Center(
            child: const Text(
              'Шпаргалка оператора/ наладчика ЧПУ',
              style: TextStyle(fontSize: fontSizeTitle),
            ),
          ),
          Image.asset('assets/img/tnl32-1.png', height: heightImgTraub),
          Text(
            'В приложении собраны М и G кода на станки со стойкой TRAUB (ТХ8Н) и FANUC 0i-tf plus производства SOWIN, а так же распространённые макросы для станков с ЧПУ.',
            style: TextStyle(fontSize: fontSizeBody),
          ),
          SizedBox(height: sizedBoxHome),
          Text(
            'Немного полезной информаци по режущему инструменту.',
            style: TextStyle(fontSize: fontSizeBody),
          ),
          SizedBox(height: sizedBoxHome),
          Center(
            child: Text(''' Радиус резьбофрез:
            М2 - 0,75
            М2,5 - 095
            М3 - 1,17
            М4 - 1,57
            М5 - 1,97
            М6 - 2,37
            М8 - 2,95
            М10 - 3,87
            М12 - 4,975''', style: TextStyle(fontSize: fontSizeBody)),
          ),
          SizedBox(height: sizedBoxHome),
          Center(
            child: Text(''' Радиус пазовых фрез:
              7,85
              8,85
              10,85
              17,85''', style: TextStyle(fontSize: fontSizeBody)),
          ),
        ],
      ),
    );
  }
}
