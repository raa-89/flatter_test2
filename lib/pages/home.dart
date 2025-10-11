// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/DrawerScreen.dart';
import 'package:test2/pages/const.dart';

class homePages extends StatefulWidget {
  const homePages({super.key});

  @override
  State<homePages> createState() => homePagesState();
}

class homePagesState extends State<homePages> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  static late Object titleFromDrawer;

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = drawerOpenXOffset;
      yOffset = drawerOpenYOffset;
      isDrawerOpen = true;
    });
  }

  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? 'Домашний экран';
    return Scaffold(
      body: Stack(
        children: [
          Drawerscreen(drawerClose: closeDrawer),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              // ignore: deprecated_member_use
              ..scale(isDrawerOpen ? drawerOpenScale : drawerCloseScale)
              ..rotateZ(
                isDrawerOpen ? drawerOpenRotation : drawerCloseRotation,
              ),
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(radiusCont)
                  : BorderRadius.circular(0),
              color: Colors.white,
            ),
            /* color: Colors.white, */
            child: GestureDetector(
              onTap: isDrawerOpen ? closeDrawer : null,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: standing_up_to_uppbar,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isDrawerOpen
                                  ? GestureDetector(
                                      child: Icon(Icons.arrow_back_ios_new),
                                      onTap: () => closeDrawer(),
                                    )
                                  : GestureDetector(
                                      child: Icon(Icons.menu),
                                      onTap: () => openDrawer(),
                                    ),
                              Expanded(
                                child: Center(
                                  child: Text(titleFromDrawer as String),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SingleChildScrollView(child: HomeBody())),
                ],
              ),
            ),
          ),
        ],
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
              17,85
              ''', style: TextStyle(fontSize: fontSizeBody)),
          ),
        ],
      ),
    );
  }
}
