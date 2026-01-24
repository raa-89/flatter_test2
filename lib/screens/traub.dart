// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:test2/core/mixin/base_operation_mixin.dart';
import 'package:test2/screens/DrawerScreen.dart';
import 'package:test2/widgets/buttonNavigation.dart';
import 'package:test2/core/const.dart';

class BodyTraub extends StatefulWidget {
  const BodyTraub({super.key});

  @override
  State<BodyTraub> createState() => BodyTraubState();
}

class BodyTraubState extends State<BodyTraub> with OperationMixin<BodyTraub> {
  // ignore: unused_field

  int pages = 1;
  // Widget widgetBody = const Traub_g_kod();
  static late Object titleFromDrawer;

  @override
  String machine = PagesConstants.titleTraub;
  @override
  String nameCode = PagesConstants.nameCodeGkod;

  @override
  void initState() {
    super.initState();
    initializeApp(machine: machine, nameCode: nameCode);
  }

  Widget _buildContent() {
    return Column(
      children: [
        buildSearchField(),
        Expanded(child: buildOperationsList(isNotes: isNotes)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Drawerscreen(drawerClose: closeDrawer),
          SafeArea(
            child: AnimatedContainer(
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
                    startDragX = details.globalPosition.dx,
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > deltaDx) openDrawer();
                  if (details.delta.dx < -deltaDx) closeDrawer();
                },
                child: Column(
                  children: <Widget>[
                    // Заголовок
                    SizedBox(
                      height: standing_up_to_uppbar,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? GestureDetector(
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: iconSizeDrawer,
                                    ),
                                    onTap: () => closeDrawer(),
                                  )
                                : GestureDetector(
                                    child: const Icon(
                                      Icons.menu,
                                      size: iconSizeDrawer,
                                    ),
                                    onTap: () => openDrawer(),
                                  ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  titleFromDrawer as String,
                                  style: const TextStyle(
                                    fontSize: fontSizeTitle,
                                  ),
                                ),
                              ),
                            ),
                            nameCode == 'Macros'
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: reloadApp,
                                    icon: const Icon(Icons.repeat),
                                    tooltip: 'Вернуть в первоночальный вид',
                                  ),
                            nameCode == 'Macros'
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: addOperation,
                                    icon: const Icon(Icons.add),
                                    tooltip: 'Добавить',
                                  ),
                          ],
                        ),
                      ),
                    ),

                    // Основной контент (занимает все доступное пространство)
                    Expanded(
                      child: isLoading
                          ? buildLoadingWidget()
                          : hasError
                          ? buildErrorWidget(initializeApp)
                          : _buildContent(),
                    ),

                    // Нижняя навигация
                    NewButtonNavigation(
                      onDataChanged: kolbeckData,
                      tooltip1: PagesConstants.nameCodeGkod,
                      tooltip2: PagesConstants.nameCodeMkod,
                      tooltip3: PagesConstants.nameCodeMacros,
                      isDrawerOpen: isDrawerOpen,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // floatingActionButton: NewFloatingActionButton(),
    );
  }
}
