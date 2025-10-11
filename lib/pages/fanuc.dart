import 'package:flutter/material.dart';
import 'package:test2/pages/DrawerScreen.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/data/fanuc_g.dart';
import 'package:test2/pages/data/fanuc_m.dart';
import 'package:test2/pages/data/fanuc_macros.dart';

class BodyFanuc extends StatefulWidget {
  const BodyFanuc({super.key});

  @override
  State<BodyFanuc> createState() => BodyFanucState();
}

class BodyFanucState extends State<BodyFanuc> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int pages = 1;
  Widget widgetBody = fanuc_G_kod();
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
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';
    return Scaffold(
      body: Stack(
        children: [
          Drawerscreen(drawerClose: closeDrawer,),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              // ignore: deprecated_member_use
              ..scale(isDrawerOpen ? drawerOpenScale : drawerCloseScale)
              ..rotateZ(isDrawerOpen ? drawerOpenRotation : 0),
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(radiusCont)
                  : BorderRadius.circular(0),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: isDrawerOpen ? () => closeDrawer() : null,
              child: Column(
                children: [
                  // Заголовок
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
                              child: Text(
                                titleFromDrawer as String,
                                style: TextStyle(fontSize: fontSizeTitle),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  // Основной контент (занимает все доступное пространство)
                  Expanded(child: widgetBody),
              
                  // Нижняя навигация
                  NewButtonNavigation(
                    onDataChanged: kolbeckData,
                    tooltip1: 'G - kod',
                    tooltip2: 'M - kod',
                    tooltip3: 'Makros',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
