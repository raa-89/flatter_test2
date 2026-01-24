// import 'package:flutter/material.dart';
// import 'package:test2/const.dart';

// class Rezba extends StatefulWidget {
//   const Rezba({super.key});

//   @override
//   State<Rezba> createState() => _RezbaState();
// }

// class _RezbaState extends State<Rezba> {
//   FixedExtentScrollController scrollController = FixedExtentScrollController();
//   String textData = 'Выбери резьбу';
//   String selectedValue = 'М2';
//   final List<String> rezba = [
//     'М2',
//     'М2,5',
//     'М3',
//     'М4',
//     'М5',
//     'М6',
//     'М8',
//     'М10',
//     'М12',
//   ];
//   int val = 0;
//   String shagRezibi = '';

//   final FixedExtentScrollController _scrollController =
//       FixedExtentScrollController();

//   // void _sendData({required String text}) {
//   //   Navigator.of(context).pop(text);
//   //   setState(() {
//   //     textData = text;
//   //     if (kDebugMode) {
//   //       print(textData);
//   //     }
//   //   });
//   // }

//   // void _showSelectionModal() {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (context) => ListView.builder(
//   //       itemCount: rezba.length,
//   //       itemBuilder: (BuildContext context, int index) {
//   //         final rezb = rezba[index];
//   //         return ListTile(
//   //           title: Text(rezb),
//   //           onTap: () {
//   //             _sendData(text: rezb);
//   //           },
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         // backgroundColor: Colors.blueGrey,
//         backgroundColor: Colors.transparent, //прозрачный фон, это важно
//         elevation: 0, //тень в 0
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//         ),

//         title: const Text('Всё про резьбофрезерование'),
//       ),
//       body: ListWheelScrollView(
//         controller: scrollController,
//         itemExtent: 1,
//         children: [
//           Column(
//             children: [
//               Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Text(
//                     rezba[val],
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: sizedBoxHome),
//                   textRezba(rezba[val]),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 2),
//                     margin: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           '''Код для ${PagesConstants.titleTraub}:
//                   G337 X0 Y0 Z-7.0 F50.0 ${rezba[val]} P$shagRezibi''',
//                           style: const TextStyle(
//                             fontSize: fontSizeBody,
//                             fontWeight: TextConst.fontWeightBody,
//                           ),
//                         ),
//                         const SizedBox(height: sizedBoxHome),
//                         const SizedBox(height: sizedBoxHome),
//                         //               const Text(
//                         //                 '''  *    Диаметры сверл указаны для 75% заполнения резьбы, для глухих отверстий добавляйте 1-2 мм на запас.
//                         // При работе с твердыми материалами уменьшайте диаметр сверла на 0.1 мм, для алюминия можно увеличить диаметр сверла на 0.1 мм.
//                         //     ''',
//                         //                 style: TextStyle(
//                         //                   fontSize: fontSizeBody,
//                         //                   fontWeight: TextConst.fontWeightBody,
//                         //                 ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Выбери резьбу:',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: sizedBoxHome),
//               SizedBox(height: 50, child: _myHorizontalListWheelScrollView()),
//               const SizedBox(height: sizedBoxHome),
//               // Expanded(
//               //   child: _myListWheelScrollView(),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _myListWheelScrollView() {
//   //   return Column(
//   //     children: [
//   //       Expanded(
//   //         // Убрали этот Expanded
//   //         child: RotatedBox(
//   //           quarterTurns: -1,
//   //           child: ListWheelScrollView.useDelegate(
//   //             controller: _scrollController,
//   //             itemExtent: 70,
//   //             diameterRatio: 0.5,
//   //             physics: const FixedExtentScrollPhysics(),
//   //             onSelectedItemChanged: (index) {
//   //               setState(() {
//   //                 val = index;
//   //               });
//   //             },
//   //             childDelegate: ListWheelChildLoopingListDelegate(
//   //               children: List.generate(
//   //                 rezba.length,
//   //                 (i) => Center(
//   //                   child: RotatedBox(
//   //                     quarterTurns: 1,
//   //                     child: Text(
//   //                       rezba[i],
//   //                       style: TextStyle(
//   //                         fontSize: 16,
//   //                         color: i == val ? Colors.blue : Colors.black,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _myHorizontalListWheelScrollView() {
//     return RotatedBox(
//       quarterTurns: -1, // Поворачиваем на 90 градусов против часовой
//       child: ListWheelScrollView.useDelegate(
//         controller: _scrollController,
//         itemExtent: 80, // Ширина элементов в горизонтальном положении
//         diameterRatio: 1.5,
//         physics: const FixedExtentScrollPhysics(),
//         onSelectedItemChanged: (index) {
//           setState(() {
//             val = index;
//           });
//         },
//         childDelegate: ListWheelChildLoopingListDelegate(
//           children: List.generate(
//             rezba.length,
//             (i) => RotatedBox(
//               quarterTurns: 1, // Поворачиваем текст обратно
//               child: Center(
//                 child: Text(
//                   rezba[i],
//                   style: TextStyle(
//                     fontSize: i == val ? 25 : 18,
//                     fontWeight: FontWeight.bold,
//                     color: i == val ? const Color(0xFF667eea) : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget myDropdownButton() {
//     return DropdownButton<String>(
//       value: selectedValue,
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedValue = newValue!;
//         });
//       },
//       items: rezba.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(value: value, child: Text(value));
//       }).toList(),
//     );
//   }

//   Widget textRezba(String rezba) {
//     switch (rezba) {
//       case 'М2':
//         shagRezibi = '0.4';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы   $rezba - 0,75 
// Стандартный шаг резьбы: $shagRezibi мм
// Диаметр сверла под резьбу: 1.6 мм
// Наружный диаметр резьбы: 2.0 мм
// Средний диаметр резьбы: 1.74 мм
// Внутренний диаметр резьбы: 1.57 мм
// ''',
//         );
//       case 'М2,5':
//         shagRezibi = '0.45';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 0,95 
// Стандартный шаг резьбы: $shagRezibi мм
// Диаметр сверла под резьбу: 2.05 мм
// Наружный диаметр резьбы: 2.5 мм
// Средний диаметр резьбы: 2.21 мм
// Внутренний диаметр резьбы: 2.01 мм
//         ''',
//         );
//       case 'М3':
//         shagRezibi = '0.5';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 1,17 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 2.5 мм
// Наружный диаметр резьбы: 3.0 мм
// Средний диаметр резьбы: 2.68 мм
// Внутренний диаметр резьбы: 2.39 мм
//         ''',
//         );
//       case 'М4':
//         shagRezibi = '0.7';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 1,57 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 3.3 мм
// Наружный диаметр резьбы: 4.0 мм
// Средний диаметр резьбы: 3.55 мм
// Внутренний диаметр резьбы: 3.14 мм
//         ''',
//         );
//       case 'М5':
//         shagRezibi = '0.8';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 1,97 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 4.2 мм
// Наружный диаметр резьбы: 5.0 мм
// Средний диаметр резьбы: 4.48 мм
// Внутренний диаметр резьбы: 4.02 мм
//         ''',
//         );
//       case 'М6':
//         shagRezibi = '1.0';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 2,37 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 5.0 мм
// Наружный диаметр резьбы: 6.0 мм
// Средний диаметр резьбы: 5.35 мм
// Внутренний диаметр резьбы: 4.70 мм
//         ''',
//         );
//       case 'М8':
//         shagRezibi = '2.95';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 2,95 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 6.7 мм
// Наружный диаметр резьбы: 8.0 мм
// Средний диаметр резьбы: 7.19 мм
// Внутренний диаметр резьбы: 6.47 мм
//         ''',
//         );
//       case 'М10':
//         shagRezibi = '1.5';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 3,87 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 8.5 мм
// Наружный диаметр резьбы: 10.0 мм
// Средний диаметр резьбы: 9.03 мм
// Внутренний диаметр резьбы: 8.16 мм
//         ''',
//         );
//       case 'М12':
//         shagRezibi = '1.75';
//         return Text(
//           style: const TextStyle(
//             fontSize: fontSizeBody,
//             fontWeight: TextConst.fontWeightBody,
//           ),
//           '''Радиус резьбофрезы $rezba - 4,975 
// Стандартный шаг резьбы: $shagRezibi  мм
// Диаметр сверла под резьбу: 10.2 мм
// Наружный диаметр резьбы: 12.0 мм
// Средний диаметр резьбы: 10.86 мм
// Внутренний диаметр резьбы: 9.85 мм
//         ''',
//         );
//       default:
//         return const Text('data');
//     }
//   }
// }

// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';
// import 'package:test2/core/mixin/base_operation_mixin.dart';
// import 'package:test2/screens/DrawerScreen.dart';
// import 'package:test2/const.dart';
// import 'package:test2/widgets/animated_icon.dart';
// import 'package:test2/widgets/card_home_pages.dart';
// import 'package:test2/widgets/rezba.dart';

// class homePages extends StatefulWidget {
//   const homePages({super.key});

//   @override
//   State<homePages> createState() => homePagesState();
// }

// class homePagesState extends State<homePages> with OperationMixin<homePages> {
//   static late Object titleFromDrawer;

//   // Метод build описывает пользовательский интерфейс
//   @override
//   Widget build(BuildContext context) {
//     final RouteSettings settings = ModalRoute.of(context)!.settings;
//     titleFromDrawer = settings.arguments ?? 'Домашний экран';
//     return Scaffold(
//       // key: _scaffoldKey,
//       backgroundColor: PagesConstants
//           .colorBackgraundHomePages, //######################################### изменил с белого
//       body: Stack(
//         children: [
//           Drawerscreen(drawerClose: closeDrawer),
//           SafeArea(
//             child: AnimatedContainer(
//               transform: Matrix4.translationValues(xOffset, yOffset, 0)
//                 // ignore: deprecated_member_use
//                 ..scale(isDrawerOpen ? drawerOpenScale : drawerCloseScale)
//                 ..rotateZ(
//                   isDrawerOpen ? drawerOpenRotation : drawerCloseRotation,
//                 ),
//               duration: animationDuration,
//               decoration: BoxDecoration(
//                 borderRadius: isDrawerOpen
//                     ? BorderRadius.circular(radiusCont)
//                     : BorderRadius.circular(0),
//                 color: PagesConstants
//                     .colorBackgraundHomePages, //####################### изменил с белого
//                 // color: Colors.white,
//               ),
//               /* color: Colors.white, */
//               child: GestureDetector(
//                 onTap: isDrawerOpen ? closeDrawer : null,
//                 onHorizontalDragStart: (details) =>
//                     startDragX = details.globalPosition.dx,
//                 onHorizontalDragUpdate: (details) {
//                   if (details.delta.dx > deltaDx) openDrawer();
//                   if (details.delta.dx < -deltaDx) closeDrawer();
//                 },
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: standing_up_to_uppbar,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 20),

//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 isDrawerOpen
//                                     ? GestureDetector(
//                                         child: const Icon(
//                                           Icons.arrow_back_ios_new,
//                                           size: iconSizeDrawer,
//                                         ),
//                                         onTap: () {
//                                           closeDrawer();
//                                           // Navigator.pop(context);
//                                         },
//                                       )
//                                     : GestureDetector(
//                                         child: const Icon(
//                                           Icons.menu,
//                                           size: iconSizeDrawer,
//                                         ),
//                                         onTap: () {
//                                           openDrawer();
//                                           // Navigator.pop(context);
//                                         },
//                                       ),
//                                 Expanded(
//                                   child: Center(
//                                     child: Text(titleFromDrawer as String),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Expanded(
//                       child: SingleChildScrollView(child: HomeBody()),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomeBody extends StatelessWidget {
//   const HomeBody({super.key});
//   // Метод build описывает пользовательский интерфейс
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: paddingHomeConteiner),
//       child: Column(
//         children: [
//           const Center(
//             child: Text(
//               'Шпаргалка оператора/ наладчика ЧПУ',
//               style: TextStyle(fontSize: fontSizeTitle),
//             ),
//           ),
//           Image.asset('assets/img/tnl32-1.png', height: heightImgTraub),

//           // const SizedBox(height: sizedBoxHome),
//           // const Center(
//           //   child: Text(''' Радиус пазовых фрез:
//           //     7,85
//           //     8,85
//           //     10,85
//           //     17,85
//           //     ''', style: TextStyle(fontSize: fontSizeBody)),
//           // ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 MyCardWidget(
//                   dateText: 'Параметры резьбофрезерования',
//                   widgetIcon: const MyAnimatedIcon(
//                     icon: Icons.build_circle,
//                     color: Colors.green,
//                   ),
//                   fun: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Rezba()),
//                     );
//                   },
//                 ),
//                 MyCardWidget(
//                   dateText: 'Допуски посадки ЕСЦП',
//                   widgetIcon: const Icon(Icons.align_horizontal_left_rounded),
//                   fun: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Rezba()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//####################################### из допуска
// Выбор системы
          //   Card(
          //     elevation: 4,
          //     child: Padding(
          //       padding: const EdgeInsets.all(6),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Система',
          //             style: textTheme.titleMedium?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           Row(
          //             children: [
          //               Expanded(
          //                 child: _SystemChoiceCard(
          //                   title: 'Система вала',
          //                   subtitle: 'Основное отклонение h',
          //                   isSelected: _selectedSystem == 'system_shaft',
          //                   onTap: () {
          //                     setState(() {
          //                       _selectedSystem = 'system_shaft';
          //                       _selectedToleranceGroup =
          //                           _availableToleranceGroups.first;
          //                       // Обновляем выбранный допуск после смены системы
          //                       if (_availableTolerances != null &&
          //                           _availableTolerances!.isNotEmpty) {
          //                         _selectedTolerance =
          //                             _availableTolerances!.first;
          //                       }
          //                     });
          //                   },
          //                 ),
          //               ),
          //               const SizedBox(width: 12),
          //               Expanded(
          //                 child: _SystemChoiceCard(
          //                   title: 'Система отверстия',
          //                   subtitle: 'Основное отклонение H',
          //                   isSelected: _selectedSystem == 'system_hole',
          //                   onTap: () {
          //                     setState(() {
          //                       _selectedSystem = 'system_hole';
          //                       _selectedToleranceGroup =
          //                           _availableToleranceGroups.first;
          //                       // Обновляем выбранный допуск после смены системы
          //                       if (_availableTolerances != null &&
          //                           _availableTolerances!.isNotEmpty) {
          //                         _selectedTolerance =
          //                             _availableTolerances!.first;
          //                       }
          //                     });
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),

          //   const SizedBox(height: 16),

          //   // Выбор диаметра
          //   Card(
          //     elevation: 4,
          //     child: Padding(
          //       padding: const EdgeInsets.all(16),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Диаметр, мм',
          //             style: textTheme.titleMedium?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           Slider(
          //             value: _selectedDiameter,
          //             min: 3,
          //             max: 80,
          //             divisions: 77,
          //             label: _selectedDiameter.toStringAsFixed(1),
          //             onChanged: (value) {
          //               setState(() {
          //                 _selectedDiameter = value;
          //               });
          //             },
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text('3 мм', style: textTheme.bodySmall),
          //               Text(
          //                 '${_selectedDiameter.toStringAsFixed(1)} мм',
          //                 style: textTheme.titleMedium?.copyWith(
          //                   color: colorScheme.primary,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //               Text('80 мм', style: textTheme.bodySmall),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),

          //   const SizedBox(height: 16),

          //   // Выбор группы допусков
          //   Card(
          //     elevation: 4,
          //     child: Padding(
          //       padding: const EdgeInsets.all(16),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Группа допусков',
          //             style: textTheme.titleMedium?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 12),
          //           Wrap(
          //             spacing: 8,
          //             runSpacing: 8,
          //             children: _availableToleranceGroups.map((group) {
          //               return FilterChip(
          //                 label: Text(group),
          //                 selected: _selectedToleranceGroup == group,
          //                 onSelected: (selected) {
          //                   setState(() {
          //                     _selectedToleranceGroup = group;
          //                     // Сбрасываем выбранный допуск при смене группы
          //                     if (_availableTolerances != null &&
          //                         _availableTolerances!.isNotEmpty) {
          //                       _selectedTolerance =
          //                           _availableTolerances!.first;
          //                     }
          //                   });
          //                 },
          //               );
          //             }).toList(),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),

          //   const SizedBox(height: 16),

          //   // Выбор конкретного допуска
          //   if (_availableTolerances != null &&
          //       _availableTolerances!.isNotEmpty)
          //     Card(
          //       elevation: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Квалитет',
          //               style: textTheme.titleMedium?.copyWith(
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             const SizedBox(height: 12),
          //             Wrap(
          //               spacing: 8,
          //               runSpacing: 8,
          //               children: _availableTolerances!.map((tolerance) {
          //                 return FilterChip(
          //                   label: Text(tolerance),
          //                   selected: _selectedTolerance == tolerance,
          //                   onSelected: (selected) {
          //                     setState(() {
          //                       _selectedTolerance = tolerance;
          //                     });
          //                   },
          //                 );
          //               }).toList(),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),

          //   const SizedBox(height: 24),

          //   // Результаты
          //   if (toleranceValues != null && toleranceValues.length >= 2) ...[
          //     Card(
          //       elevation: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Результаты расчета',
          //               style: textTheme.titleMedium?.copyWith(
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             const SizedBox(height: 16),
          //             _ToleranceResultCard(
          //               title: 'Нижнее отклонение',
          //               value: toleranceValues[0],
          //               unit: 'мм',
          //               color: colorScheme.primary,
          //             ),
          //             const SizedBox(height: 12),
          //             _ToleranceResultCard(
          //               title: 'Верхнее отклонение',
          //               value: toleranceValues[1],
          //               unit: 'мм',
          //               color: colorScheme.secondary,
          //             ),
          //             const SizedBox(height: 16),
          //             Container(
          //               padding: const EdgeInsets.all(12),
          //               decoration: BoxDecoration(
          //                 color: colorScheme.primary.withOpacity(0.1),
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Text(
          //                 'Диапазон: ${_selectedTolerance.toUpperCase()} '
          //                 '(${_getDiameterRange(_selectedDiameter)} мм)',
          //                 style: textTheme.bodyMedium?.copyWith(
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ] else if (toleranceValues == null) ...[
          //     Card(
          //       elevation: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Center(
          //           child: Text(
          //             'Данные для выбранных параметров не найдены',
          //             style: textTheme.bodyMedium?.copyWith(
          //               color: colorScheme.error,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],

          //   const SizedBox(height: 24),

          //   // Информация о системе
          //   Card(
          //     elevation: 2,
          //     child: Padding(
          //       padding: const EdgeInsets.all(16),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'О системе ЕСЦП',
          //             style: textTheme.titleMedium?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           const SizedBox(height: 8),
          //           Text(
          //             _selectedSystem == 'system_shaft'
          //                 ? 'Система вала - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков отверстий с полем допуска основного вала.'
          //                 : 'Система отверстия - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков валов с полем допуска основного отверстия.',
          //             style: textTheme.bodyMedium?.copyWith(
          //               color: colorScheme.onSurface.withOpacity(0.7),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ],

          // screens/tolerances_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test2/database/holeTolerances.dart';
import 'package:test2/database/shaftTolerances.dart';

class TolerancesPage extends StatefulWidget {
  const TolerancesPage({super.key});

  @override
  State<TolerancesPage> createState() => _TolerancesPageState();
}

class _TolerancesPageState extends State<TolerancesPage> {
  String _selectedSystem = 'system_shaft'; // 'system_shaft' или 'system_hole'
  String _selectedToleranceGroup = 'a'; // Группа допусков (a, b, c, и т.д.)
  String _selectedTolerance = 'a9'; // Конкретный допуск (a9, a10, и т.д.)
  double _selectedDiameter = 10.0;
  // ignore: non_constant_identifier_names
  final TextEditingController _Controller = TextEditingController();
  
  // Добавляем контроллеры для колес прокрутки
  late FixedExtentScrollController _groupScrollController;
  FixedExtentScrollController? _toleranceScrollController;

  // Получение доступных групп допусков (a, b, c, ...)
  List<String> get _availableToleranceGroups {
    return _selectedSystem == 'system_shaft'
        ? shaftTolerances.keys.toList()
        : holeTolerances.keys.toList();
  }

  // Получение доступных конкретных допусков внутри выбранной группы (a9, a10, ...)
  List<String>? get _availableTolerances {
    if (_selectedSystem == 'system_shaft') {
      return shaftTolerances[_selectedToleranceGroup]?.keys.toList();
    } else {
      return holeTolerances[_selectedToleranceGroup]?.keys.toList();
    }
  }

  @override
  void initState() {
    super.initState();
    
    // Инициализируем контроллер группы
    _groupScrollController = FixedExtentScrollController(
      initialItem: _availableToleranceGroups.indexOf(_selectedToleranceGroup),
    );
    
    // Инициализируем контроллер допусков
    _initializeToleranceController();
  }

  void _initializeToleranceController() {
    if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
      final initialIndex = _availableTolerances!.indexOf(_selectedTolerance);
      _toleranceScrollController = FixedExtentScrollController(
        initialItem: initialIndex != -1 ? initialIndex : 0,
      );
    }
  }

  void _updateToleranceScrollController() {
    // Диспозим старый контроллер
    _toleranceScrollController?.dispose();
    
    // Создаем новый контроллер
    if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
      final initialIndex = _availableTolerances!.indexOf(_selectedTolerance);
      _toleranceScrollController = FixedExtentScrollController(
        initialItem: initialIndex != -1 ? initialIndex : 0,
      );
    } else {
      _toleranceScrollController = null;
    }
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _Controller.dispose();
    _groupScrollController.dispose();
    _toleranceScrollController?.dispose();
    super.dispose();
  }

  // Получение диапазона диаметра
  String _getDiameterRange(double diameter) {
    if (diameter <= 3) return '0-3';
    if (diameter <= 6) return '3-6';
    if (diameter <= 10) return '6-10';
    if (diameter <= 14) return '10-14';
    if (diameter <= 18) return '14-18';
    if (diameter <= 24) return '18-24';
    if (diameter <= 30) return '24-30';
    if (diameter <= 40) return '30-40';
    if (diameter <= 50) return '40-50';
    if (diameter <= 65) return '50-65';
    if (diameter <= 80) return '65-80';
    if (diameter <= 100) return '80-100';
    if (diameter <= 120) return '100-120';
    if (diameter <= 140) return '120-140';
    if (diameter <= 160) return '140-160';
    if (diameter <= 180) return '160-180';
    if (diameter <= 200) return '180-200';
    if (diameter <= 225) return '200-225';
    if (diameter <= 250) return '225-250';
    if (diameter <= 280) return '250-280';
    if (diameter <= 315) return '280-315';
    if (diameter <= 355) return '315-355';
    if (diameter <= 400) return '355-400';
    if (diameter <= 450) return '400-450';
    if (diameter <= 500) return '450-500';
    if (diameter <= 560) return '500-560';
    if (diameter <= 630) return '560-630';
    if (diameter <= 710) return '630-710';
    if (diameter <= 800) return '710-800';
    if (diameter <= 900) return '800-900';
    if (diameter <= 1000) return '900-1000';
    if (diameter <= 1120) return '1000-1120';
    if (diameter <= 1250) return '1120-1250';
    if (diameter <= 1400) return '1250-1400';
    if (diameter <= 1600) return '1400-1600';
    if (diameter <= 1800) return '1600-1800';
    if (diameter <= 2000) return '1800-2000';
    if (diameter <= 2240) return '2000-2240';
    if (diameter <= 2500) return '2240-2500';
    if (diameter <= 2800) return '2500-2800';
    if (diameter <= 3150) return '2800-3150';

    return '3150+';
  }

  // Получение значений допуска
  List<double>? _getToleranceValues() {
    final range = _getDiameterRange(_selectedDiameter);

    if (_selectedSystem == 'system_shaft') {
      // Для вала: shaftTolerances[группа][допуск][диапазон]
      return shaftTolerances[_selectedToleranceGroup]?[_selectedTolerance]?[range];
    } else {
      // Для отверстия: holeTolerances[группа][допуск][диапазон]
      return holeTolerances[_selectedToleranceGroup]?[_selectedTolerance]?[range];
    }
  }

  @override
  Widget build(BuildContext context) {
    final toleranceValues = _getToleranceValues();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Допуски посадок ЕСЦП'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.primaryContainer],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Выбор системы
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Система',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _SystemChoiceCard(
                            title: 'вала (h)',
                            subtitle: '',
                            isSelected: _selectedSystem == 'system_shaft',
                            onTap: () {
                              setState(() {
                                _selectedSystem = 'system_shaft';
                                _selectedToleranceGroup = _availableToleranceGroups.first;
                                // Обновляем выбранный допуск после смены системы
                                if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
                                  _selectedTolerance = _availableTolerances!.first;
                                }
                                _updateToleranceScrollController();
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SystemChoiceCard(
                            title: 'отверстия (H)',
                            subtitle: '',
                            isSelected: _selectedSystem == 'system_hole',
                            onTap: () {
                              setState(() {
                                _selectedSystem = 'system_hole';
                                _selectedToleranceGroup = _availableToleranceGroups.first;
                                // Обновляем выбранный допуск после смены системы
                                if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
                                  _selectedTolerance = _availableTolerances!.first;
                                }
                                _updateToleranceScrollController();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Выбор диаметра
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Номинальный размер ${_selectedDiameter.toStringAsFixed(3)} мм',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _Controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Введите номинальный размер',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final String normalizedValue = value.replaceAll(',', '.');
                          final double? numericValue = double.tryParse(normalizedValue);
                          setState(() {
                            _selectedDiameter = numericValue ?? 3.0;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Выбор группы допусков
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Группа допусков',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100, // Фиксированная высота для колеса прокрутки
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: ListWheelScrollView.useDelegate(
                          controller: _groupScrollController,
                          itemExtent: 80,
                          diameterRatio: 1.5,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            final selectedGroup = _availableToleranceGroups[index];
                            setState(() {
                              _selectedToleranceGroup = selectedGroup;
                              // Сбрасываем выбранный допуск при смене группы
                              if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
                                _selectedTolerance = _availableTolerances!.first;
                              }
                              _updateToleranceScrollController();
                            });
                          },
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List.generate(
                              _availableToleranceGroups.length,
                              (index) {
                                final group = _availableToleranceGroups[index];
                                final isSelected = _selectedToleranceGroup == group;

                                return RotatedBox(
                                  quarterTurns: 1,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF667eea).withOpacity(0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF667eea)
                                              : Colors.grey[300]!,
                                          width: isSelected ? 2 : 1,
                                        ),
                                      ),
                                      child: Text(
                                        group,
                                        style: TextStyle(
                                          fontSize: isSelected ? 22 : 16,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? const Color(0xFF667eea)
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Выбор конкретного допуска
            if (_availableTolerances != null && _availableTolerances!.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Квалитет',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100, // Фиксированная высота для колеса прокрутки
                        child: _toleranceScrollController != null
                            ? RotatedBox(
                                quarterTurns: -1,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _toleranceScrollController!,
                                  itemExtent: 80,
                                  diameterRatio: 1.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      _selectedTolerance = _availableTolerances![index];
                                    });
                                  },
                                  childDelegate: ListWheelChildLoopingListDelegate(
                                    children: List.generate(
                                      _availableTolerances!.length,
                                      (index) {
                                        final tolerance = _availableTolerances![index];
                                        final isSelected = _selectedTolerance == tolerance;

                                        return RotatedBox(
                                          quarterTurns: 1,
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? const Color(0xFF667eea).withOpacity(0.1)
                                                    : Colors.transparent,
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? const Color(0xFF667eea)
                                                      : Colors.grey[300]!,
                                                  width: isSelected ? 2 : 1,
                                                ),
                                              ),
                                              child: Text(
                                                tolerance,
                                                style: TextStyle(
                                                  fontSize: isSelected ? 22 : 16,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: isSelected
                                                      ? const Color(0xFF667eea)
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Результаты
            if (toleranceValues != null && toleranceValues.length >= 2) ...[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Результаты расчета',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _ToleranceResultCard(
                        title: 'Нижнее отклонение',
                        value: toleranceValues[0],
                        unit: 'мм',
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      _ToleranceResultCard(
                        title: 'Верхнее отклонение',
                        value: toleranceValues[1],
                        unit: 'мм',
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Диапазон: ${_selectedTolerance.toUpperCase()} '
                          '(${_getDiameterRange(_selectedDiameter)} мм)',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (toleranceValues == null) ...[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Данные для выбранных параметров не найдены',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Информация о системе
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'О системе ЕСЦП',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedSystem == 'system_shaft'
                          ? 'Система вала - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков отверстий с полем допуска основного вала.'
                          : 'Система отверстия - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков валов с полем допуска основного отверстия.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
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

class _SystemChoiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _SystemChoiceCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToleranceResultCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final Color color;

  const _ToleranceResultCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: color.withOpacity(0.1),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              '${value.toStringAsFixed(3)} $unit',
              style: textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}