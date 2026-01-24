// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:test2/core/mixin/base_operation_mixin.dart';
import 'package:test2/screens/DrawerScreen.dart';
import 'package:test2/core/const.dart';
import 'package:test2/widgets/card_home_pages.dart';
import 'package:test2/screens/dopusk.dart';
import 'package:test2/screens/rezba.dart';

class homePages extends StatefulWidget {
  const homePages({super.key});

  @override
  State<homePages> createState() => homePagesState();
}

class homePagesState extends State<homePages> with OperationMixin<homePages> {
  static late Object titleFromDrawer;

  @override
  Widget build(BuildContext context) {
    final RouteSettings settings = ModalRoute.of(context)!.settings;
    titleFromDrawer = settings.arguments ?? 'Домашний экран';

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          Drawerscreen(drawerClose: closeDrawer),
          SafeArea(
            child: AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(isDrawerOpen ? drawerOpenScale : drawerCloseScale)
                ..rotateZ(
                  isDrawerOpen ? drawerOpenRotation : drawerCloseRotation,
                ),
              duration: animationDuration,
              decoration: BoxDecoration(
                borderRadius: isDrawerOpen
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(radiusCont),
                        topRight: Radius.circular(radiusCont),
                        bottomLeft: Radius.circular(radiusCont),
                        bottomRight: Radius.circular(radiusCont),
                      )
                    : BorderRadius.circular(0),
                color: colorScheme.surface,
                boxShadow: isDrawerOpen
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: isDrawerOpen
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(radiusCont),
                        topRight: Radius.circular(radiusCont),
                        bottomLeft: Radius.circular(radiusCont),
                        bottomRight: Radius.circular(radiusCont),
                      )
                    : BorderRadius.circular(0),
                child: GestureDetector(
                  onTap: isDrawerOpen ? closeDrawer : null,
                  onHorizontalDragStart: (details) =>
                      startDragX = details.globalPosition.dx,
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > deltaDx) openDrawer();
                    if (details.delta.dx < -deltaDx) closeDrawer();
                  },
                  child: Column(
                    children: [
                      // Modern App Bar
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primaryContainer,
                              ),
                              child: IconButton(
                                onPressed: isDrawerOpen
                                    ? closeDrawer
                                    : openDrawer,
                                icon: Icon(
                                  isDrawerOpen
                                      ? Icons.arrow_back_ios_new
                                      : Icons.menu,
                                  size: 20,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  titleFromDrawer as String,
                                  style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40), // For balance
                          ],
                        ),
                      ),

                      const Expanded(child: HomeBody()),
                    ],
                  ),
                ),
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withOpacity(0.8),
                        colorScheme.primaryContainer,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Шпаргалка оператора/\nналадчика ЧПУ',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onPrimary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Все необходимые инструменты и расчеты в одном месте',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Machine Image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/img/tnl32-1.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),

        // Tools Grid Section
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.83,
            ),
            delegate: SliverChildListDelegate([
              MyCardWidget(
                // context,
                title: 'Резьбофрезерование',
                subtitle: 'Параметры и коды',
                icon: const Icon(Icons.build_circle, color: Colors.white54),
                gradientColors: const [
                  Color.fromARGB(255, 10, 40, 105),
                  Color.fromARGB(204, 34, 34, 133),
                ],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Rezba()),
                  );
                },
              ),

              MyCardWidget(
                // context,
                title: 'Допуски ЕСДП',
                subtitle: 'Посадки и допуски',
                icon: const Icon(
                  Icons.align_horizontal_left_rounded,
                  color: Colors.white,
                ),
                gradientColors: const [
                  Color.fromARGB(255, 21, 0, 117),
                  Color.fromARGB(90, 10, 108, 90),
                ],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TolerancesPage(),
                    ),
                  );
                },
              ),

              // MyCardWidget(
              //   // context,
              //   title: 'Фрезы',
              //   subtitle: 'Параметры инструментов',
              //   icon: const Icon(Icons.construction, color: Colors.white),
              //   gradientColors: const [
              //     Color.fromARGB(255, 34, 34, 133),
              //     Color.fromARGB(111, 37, 149, 128),
              //   ],
              //   onTap: () {

              //   },
              // ),
              // MyCardWidget(
              //   // context,
              //   title: 'Расчеты',
              //   subtitle: 'Калькуляторы',
              //   icon: const Icon(Icons.calculate, color: Colors.white),
              //   gradientColors: const [
              //     Color.fromARGB(255, 34, 79, 133),
              //     Color.fromARGB(94, 53, 248, 212),
              //   ],
              //   onTap: () {},
              // ),
            ]),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
