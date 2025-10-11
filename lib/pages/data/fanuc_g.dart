// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test2/pages/Search.dart';

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
    _searchController.addListener(_filterLines);
    _filteredLines = lines;
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
    return BodySearchKod(
      searchController: _searchController,
      filteredLines: _filteredLines,
    );
  }
}

