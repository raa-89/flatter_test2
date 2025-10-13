import 'package:flutter/material.dart';
import 'package:test2/pages/DrawerScreen.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/data/syntec_g.dart';
import 'package:test2/pages/data/taub_g.dart';
import 'package:test2/pages/routes.dart';

class BodySyntec extends StatefulWidget {
  const BodySyntec({super.key});

  @override
  State<BodySyntec> createState() => BodySyntecState();
}

class BodySyntecState extends State<BodySyntec> {
  // ignore: unused_field
  double _startDragX = 0.0;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int pages = 1;
  Widget widgetBody = Traub_g_kod();
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
        widgetBody = SyntecG();
      } else if (pages == 2) {
        widgetBody = SyntecG();
      } else {
        widgetBody = SyntecG();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      home: Scaffold(
        body: Stack(
          children: [
            Drawerscreen(drawerClose: closeDrawer),
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
                onHorizontalDragStart: (details) =>
                    _startDragX = details.globalPosition.dx,
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > deltaDx) openDrawer();
                  if (details.delta.dx < -deltaDx) closeDrawer();
                },
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
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: iconSizeDrawer,
                                    ),
                                    onTap: () => closeDrawer(),
                                  )
                                : GestureDetector(
                                    child: Icon(
                                      Icons.menu,
                                      size: iconSizeDrawer,
                                    ),
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
      ),
    );
  }
}
