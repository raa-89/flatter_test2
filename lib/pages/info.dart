// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/DrawerScreen.dart';
import 'package:test2/pages/const.dart';

class InfoPages extends StatefulWidget {
  const InfoPages({super.key});

  @override
  State<InfoPages> createState() => _InfoPagesState();
}

class _InfoPagesState extends State<InfoPages> {
    // ignore: unused_field
  double _startDragX = 0.0;
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
    final RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';
    return Scaffold(
      body: Stack(
        children: [
          Drawerscreen(drawerClose: () => closeDrawer()),
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
              onTap: isDrawerOpen ? () => closeDrawer() : null,
              onHorizontalDragStart: (details) =>
                  _startDragX = details.globalPosition.dx,
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > deltaDx) openDrawer();
                if (details.delta.dx < -deltaDx) closeDrawer();
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: standing_up_to_uppbar,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isDrawerOpen
                                  ? GestureDetector(
                                      child: const Icon(Icons.arrow_back_ios_new,
                                        size: iconSizeDrawer),
                                      onTap: () => closeDrawer(),
                                    )
                                  : GestureDetector(
                                      child: const Icon(Icons.menu,
                                        size: iconSizeDrawer),
                                      onTap: () => openDrawer(),
                                    ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    titleFromDrawer as String,
                                    style: const TextStyle(fontSize: fontSizeTitle),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Scrollbar(
                      trackVisibility: false,
                      thickness: thicknessScrollbar,
                      radius: Radius.circular(radiusScrollbar),
                      interactive: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: InfoBody(),
                      ),
                    ),
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

class InfoBody extends StatelessWidget {
  const InfoBody({super.key});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: paddingHomeConteiner),
      child: const Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/img/kot.jpg'),
              radius: 100,
            ),
          ),
          SizedBox(height: sizedBoxHome * 2),
          Text(
            'Приложение было создано с целью облегчить жизнь наладчику или оператору станков с ЧПУ для более лёгкого чтения программ, и как следствие уменьшения брака.',
            style: TextStyle(fontSize: fontSizeBody),
          ),

          SizedBox(height: sizedBoxHome),
        ],
      ),
    );
  }
}
