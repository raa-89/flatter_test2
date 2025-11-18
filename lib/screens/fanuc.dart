// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:test2/core/mixin/base_operation_mixin.dart';
import 'package:test2/screens/DrawerScreen.dart';
import 'package:test2/widgets/buttonNavigation.dart';
import 'package:test2/const.dart';

class BodyFanuc extends StatefulWidget {
  const BodyFanuc({super.key});

  @override
  State<BodyFanuc> createState() => BodyFanucState();
}

class BodyFanucState extends State<BodyFanuc> with OperationMixin<BodyFanuc> {
  // ignore: unused_field
  double _startDragX = 0.0;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int pages = 1;
  // Widget widgetBody = const fanuc_G_kod();
  static late Object titleFromDrawer;

  @override
  String machine = "FANUC 0i-tf plus (sowin)";
  @override
  String nameCode = "G - kod";
  // final OperationService _operationService = OperationService();
  // List<Operation> _operations = [];
  // bool _isLoading = true;
  // bool _hasError = false;
  // bool _isNotes = false;
  // String _errorMessage = '';
  // String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

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

  Widget _buildContent() {
    return Column(
      children: [
        buildSearchField(),
        Expanded(
          child: buildOperationsList(isNotes: isNotes),
          // separatorBuilder: (BuildContext context, int index) {
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: Divider(height: 1.0, color: Colors.black),
          //   );
          // },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? '';
    // machine = titleFromDrawer as String;
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
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
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
                            IconButton(
                              onPressed: reloadApp,
                              icon: const Icon(Icons.repeat),
                              tooltip: 'Вернуть в первоночальный вид',
                            ),
                            IconButton(
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
                      tooltip1: 'G - kod',
                      tooltip2: 'M - kod',
                      tooltip3: 'Makros',
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
