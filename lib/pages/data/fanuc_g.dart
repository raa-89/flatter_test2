// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/buttonNavigation.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/routes.dart';

class fanuc_G_kod extends StatefulWidget {
  const fanuc_G_kod({super.key});

  @override
  State<fanuc_G_kod> createState() => _fanuc_G_kodState();
}

class _fanuc_G_kodState extends State<fanuc_G_kod> {
  List<String> _allLines = [];
  List<String> _filteredLines = [];
  final TextEditingController _searchController = TextEditingController();
  final lines = <String>[
    "G00 Прямо на ускорреном ходу",
    "G01* Подача по прямой/ линейная интерполяция",
    "G02 Круговая интерполяция по часовой стрелке",
    "G03 Круговая интерполяция против часовой стрелки",
    "G04 Время ожидания",
    "G07.1 (G107) Цилиндрическая интерполяция",
    "G09 Точная остановка",
    "G10 Программируемый ввод данных",
    "G12.1 (G112) Интерполяция в полярных координатах ВКЛ.",
    "G13.1 (G113) Интерполяция в полярных координатах ВЫКЛ.",
    "G17 Плоскость фрезерования X-Y",
    "G18 Плоскость фрезерования X-Z",
    "G19 Плоскость фрезерования Y-Z",
    "G20 Выбор программирования в дюймах",
    "G21 Выбор программирования в мм",
    "G28 Подвод к точке начала отсчёта",
    "G32 Нарезание резьбы c постоянным шагом",
    "G34 Нарезание резьбы с переменным шагом",
    "G40 Компенсация радиуса режущей кромки выключена",
    "G41 Компенсация радиуса резца или фрезы включена, инструмент слева от контура ",
    "G42 Компенсация радиуса резца или фрезы включена, инструмент справа от контура",
    "G50 Смещение СК/ задание ограничения частоты вращения шпинделя",
    "G50.2 (G250) Обработка полигона ВЫКЛ.",
    "G51.2 (G251) Обработка полигона ВКЛ.",
    "G65 Вызов макропрограммы",
    "G66 Макро режим ВКЛ",
    "G67 Макро режим ВЫКЛ",
    "G70 Цикл прецизионной обработки",
    "G71 Цикл черновой наружной обработки",
    "G72 Цикл чистовой обработки/ торцевания",
    "G73 Цикл черновой обработки – параллельно контуру",
    "G74 Цикл черновой обработки с прерывистым резанием – продольно",
    "G75 Цикл черновой обработки с прерывистым резанием – поперечно",
    "G76 Многопроходный цикл нарезания резьбы ",
    "G80 Отмена цикла сверления",
    "G83 Цикл осевого сверления",
    "G84 Цикл осевого нарезания резьбы",
    "G184 Цикл нарезания резьбы приводным иснтрументом",
    "G87 Циклы радиального сверления",
    "G188 Цикл радиального нарезания резьбы",
    "G90 Цикл НАР/ ВНУТР точения",
    "G92 Цикл нарезания резьбы",
    "G96 Постоянная скорость резания",
    "G97 Отмена постоянного контроля скорости резания",
    "G98 Подача в мм/мин",
    "G99 Подача в мм/оборот",
    "G150 Задание СК (после G300, только для оси Z1)",
    "G266 Задание параметра",
    "G300 Сброс СК (X1, Z1, Y1)",
    "G310 Сброс СК (X2, Z2, Y2)",
  ];

  @override
  void initState() {
    super.initState();
    /*  _loadTextFile(); */
    _searchController.addListener(_filterLines);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLines() {
    setState(() {
      _allLines = lines;
      _filteredLines = lines;
    });
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredLines = lines;
      });
    } else {
      setState(() {
        _filteredLines = _allLines
            .where((line) => line.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'title from material app',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorApp,
          title: Text('funuc g kod'),
          centerTitle: true,
          leading: Icon(Icons.menu),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Поисковая строка
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Поиск',
                  hintText: 'Введите текст для поиска...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Разделитель
            Divider(),

            // Список строк
            Expanded(
              child: _filteredLines.isEmpty
                  ? _MyListeView()
                  : ListView.separated(
                      itemCount: _filteredLines.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _filteredLines[index],
                            style: TextStyle(fontSize: fontSizeBody),
                          ),
                          /* leading: CircleAvatar(child: Text('${index + 1}')), */
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Divider(height: 1.0, color: colorDivider),
                          ),
                    ),
            ),
          ],
        ),

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

class BodyListView extends StatelessWidget {
  const BodyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return _MyListeView();
  }
}

// ignore: non_constant_identifier_names
Widget _MyListeView() {
  final myList = <String>[
    "G00 Прямо на ускорреном ходу",
    "G01* Подача по прямой/ линейная интерполяция",
    "G02 Круговая интерполяция по часовой стрелке",
    "G03 Круговая интерполяция против часовой стрелки",
    "G04 Время ожидания",
    "G07.1 (G107) Цилиндрическая интерполяция",
    "G09 Точная остановка",
    "G10 Программируемый ввод данных",
    "G12.1 (G112) Интерполяция в полярных координатах ВКЛ.",
    "G13.1 (G113) Интерполяция в полярных координатах ВЫКЛ.",
    "G17 Плоскость фрезерования X-Y",
    "G18 Плоскость фрезерования X-Z",
    "G19 Плоскость фрезерования Y-Z",
    "G20 Выбор программирования в дюймах",
    "G21 Выбор программирования в мм",
    "G28 Подвод к точке начала отсчёта",
    "G32 Нарезание резьбы c постоянным шагом",
    "G34 Нарезание резьбы с переменным шагом",
    "G40 Компенсация радиуса режущей кромки выключена",
    "G41 Компенсация радиуса резца или фрезы включена, инструмент слева от контура ",
    "G42 Компенсация радиуса резца или фрезы включена, инструмент справа от контура",
    "G50 Смещение СК/ задание ограничения частоты вращения шпинделя",
    "G50.2 (G250) Обработка полигона ВЫКЛ.",
    "G51.2 (G251) Обработка полигона ВКЛ.",
    "G65 Вызов макропрограммы",
    "G66 Макро режим ВКЛ",
    "G67 Макро режим ВЫКЛ",
    "G70 Цикл прецизионной обработки",
    "G71 Цикл черновой наружной обработки",
    "G72 Цикл чистовой обработки/ торцевания",
    "G73 Цикл черновой обработки – параллельно контуру",
    "G74 Цикл черновой обработки с прерывистым резанием – продольно",
    "G75 Цикл черновой обработки с прерывистым резанием – поперечно",
    "G76 Многопроходный цикл нарезания резьбы ",
    "G80 Отмена цикла сверления",
    "G83 Цикл осевого сверления",
    "G84 Цикл осевого нарезания резьбы",
    "G184 Цикл нарезания резьбы приводным иснтрументом",
    "G87 Циклы радиального сверления",
    "G188 Цикл радиального нарезания резьбы",
    "G90 Цикл НАР/ ВНУТР точения",
    "G92 Цикл нарезания резьбы",
    "G96 Постоянная скорость резания",
    "G97 Отмена постоянного контроля скорости резания",
    "G98 Подача в мм/мин",
    "G99 Подача в мм/оборот",
    "G150 Задание СК (после G300, только для оси Z1)",
    "G266 Задание параметра",
    "G300 Сброс СК (X1, Z1, Y1)",
    "G310 Сброс СК (X2, Z2, Y2)",
  ];

  return ListView.separated(
    padding: EdgeInsets.all(2),
    scrollDirection: Axis.vertical,
    //itemExtent: 30,
    itemCount: myList.length,
    itemBuilder: (context, index) => Column(
      children: [
        ListTile(
          title: Text(myList[index], style: TextStyle(fontSize: fontSizeBody)),
        ),
      ],
    ),
    separatorBuilder: (BuildContext context, int index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(height: 1.0, color: colorDivider),
    ),
  );
}
