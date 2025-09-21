// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/routes.dart';

class homePages extends StatefulWidget {
  const homePages({super.key});

  @override
  State<homePages> createState() => _homePagesState();
}

class _homePagesState extends State<homePages> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return /* MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,

      home: Scaffold( */
    /* appBar: AppBar(
          backgroundColor: colorApp,
             title: const Text('Домашний экран'),
          centerTitle: true,
          leading: Icon(Icons.menu),
        ), */
    //backgroundColor: Colors.white,
    /* body: */ AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen
                            ? GestureDetector(
                                child: Icon(Icons.arrow_back_ios_new),
                                onTap: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    isDrawerOpen = false;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Icon(Icons.menu),
                                onTap: () {
                                  setState(() {
                                    xOffset = 290;
                                    yOffset = 80;
                                    isDrawerOpen = true;
                                  });
                                },
                              ),
                        Center(child: Text('')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            HomeBody(),
          ],
        ),
      ),
    );
    /* bottomNavigationBar: NewButtonNavigation(
          tooltip1: 'G - kod',
          tooltip2: 'M - kod',
          tooltip3: 'Makros',
          onPressedWidget1: AppRoutes.fanuc,
          onPressedWidget2: AppRoutes.fanuc,
          onPressedWidget3: AppRoutes.home,
          onDataChanged: (int p1) {},
        ), */
    /*      ),
    ); */
  }
}

/*
class NewAppBar extends StatefulWidget {
  const NewAppBar({super.key});

  @override
  State<NewAppBar> createState() => _NewAppBarState();
}

 class _NewAppBarState extends State<NewAppBar> {
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(Icons.menu),
                  onTap: () {
                    setState(() {
                      xOffset = 290;
                      yOffset = 80;
                      isDrawerOpen = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} */

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
              17,85
              ''', style: TextStyle(fontSize: fontSizeBody)),
          ),
        ],
      ),
    );
  }
}
