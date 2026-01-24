import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:test2/core/const.dart';

class Rezba extends StatefulWidget {
  const Rezba({super.key});

  @override
  State<Rezba> createState() => _RezbaState();
}

class _RezbaState extends State<Rezba> {
  final ScrollController _scrollController = ScrollController();
  String textData = 'Выбери резьбу';
  String selectedValue = 'М2';
  final List<String> rezba = [
    'М2',
    'М2,5',
    'М3',
    'М4',
    'М5',
    'М6',
    'М8',
    'М10',
    'М12',
  ];
  int val = 0;
  String shagRezibi = '';

  final FixedExtentScrollController _wheelScrollController =
      FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        title: const AutoSizeText(
          'Всё про резьбофрезерование',
          style: TextStyle(fontSize: 22), // начальный размер
          minFontSize: 12, // минимальный размер
          maxLines: 2, // максимальное количество строк
          overflow: TextOverflow.ellipsis, // что делать если не помещается),
        ),
      ),
      body: RawScrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 8.0,
        radius: const Radius.circular(4),
        interactive: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Основная информация о резьбе
                Card(
                  color: PagesConstants.colorBackgraundCard,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          rezba[val],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF667eea),
                          ),
                        ),
                        // const SizedBox(height: 10),
                        textRezba(rezba[val]),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Код для ${PagesConstants.titleTraub}:\n'
                              'G337 X0 Y0 Z-7.0 F50.0 ${rezba[val]} P$shagRezibi',
                              style: const TextStyle(
                                fontSize: fontSizeBody,
                                fontWeight: TextConst.fontWeightBody,
                                fontFamily: 'Monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Колесо выбора резьбы
                Card(
                  color: PagesConstants.colorBackgraundCard,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          'Выбери резьбу:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 120,
                          child: _myHorizontalListWheelScrollView(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Дополнительная информация
                // const Card(
                //   elevation: 4,
                //   child: Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Text(
                //       '* Диаметры сверл указаны для 75% заполнения резьбы, для глухих отверстий добавляйте 1-2 мм на запас.\n'
                //       '* При работе с твердыми материалами уменьшайте диаметр сверла на 0.1 мм, для алюминия можно увеличить диаметр сверла на 0.1 мм.',
                //       style: TextStyle(
                //         fontSize: fontSizeBody,
                //         fontWeight: TextConst.fontWeightBody,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myHorizontalListWheelScrollView() {
    return RotatedBox(
      quarterTurns: -1,
      child: ListWheelScrollView.useDelegate(
        controller: _wheelScrollController,
        itemExtent: 80,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            val = index;
          });
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(
            rezba.length,
            (i) => RotatedBox(
              quarterTurns: 1,
              child: Center(
                child: Text(
                  rezba[i],
                  style: TextStyle(
                    fontSize: i == val ? 25 : 18,
                    fontWeight: FontWeight.bold,
                    color: i == val ? const Color(0xFF667eea) : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textRezba(String rezba) {
    switch (rezba) {
      case 'М2':
        shagRezibi = '0.4';
        return _buildRezbaInfo(
          radius: '0,75',
          drillDiameter: '1.6 мм',
          outerDiameter: '2.0 мм',
          middleDiameter: '1.74 мм',
          innerDiameter: '1.57 мм',
        );
      case 'М2,5':
        shagRezibi = '0.45';
        return _buildRezbaInfo(
          radius: '0,95',
          drillDiameter: '2.05 мм',
          outerDiameter: '2.5 мм',
          middleDiameter: '2.21 мм',
          innerDiameter: '2.01 мм',
        );
      case 'М3':
        shagRezibi = '0.5';
        return _buildRezbaInfo(
          radius: '1,17',
          drillDiameter: '2.5 мм',
          outerDiameter: '3.0 мм',
          middleDiameter: '2.68 мм',
          innerDiameter: '2.39 мм',
        );
      case 'М4':
        shagRezibi = '0.7';
        return _buildRezbaInfo(
          radius: '1,57',
          drillDiameter: '3.3 мм',
          outerDiameter: '4.0 мм',
          middleDiameter: '3.55 мм',
          innerDiameter: '3.14 мм',
        );
      case 'М5':
        shagRezibi = '0.8';
        return _buildRezbaInfo(
          radius: '1,97',
          drillDiameter: '4.2 мм',
          outerDiameter: '5.0 мм',
          middleDiameter: '4.48 мм',
          innerDiameter: '4.02 мм',
        );
      case 'М6':
        shagRezibi = '1.0';
        return _buildRezbaInfo(
          radius: '2,37',
          drillDiameter: '5.0 мм',
          outerDiameter: '6.0 мм',
          middleDiameter: '5.35 мм',
          innerDiameter: '4.70 мм',
        );
      case 'М8':
        shagRezibi = '1.25';
        return _buildRezbaInfo(
          radius: '2,95',
          drillDiameter: '6.7 мм',
          outerDiameter: '8.0 мм',
          middleDiameter: '7.19 мм',
          innerDiameter: '6.47 мм',
        );
      case 'М10':
        shagRezibi = '1.5';
        return _buildRezbaInfo(
          radius: '3,87',
          drillDiameter: '8.5 мм',
          outerDiameter: '10.0 мм',
          middleDiameter: '9.03 мм',
          innerDiameter: '8.16 мм',
        );
      case 'М12':
        shagRezibi = '1.75';
        return _buildRezbaInfo(
          radius: '4,975',
          drillDiameter: '10.2 мм',
          outerDiameter: '12.0 мм',
          middleDiameter: '10.86 мм',
          innerDiameter: '9.85 мм',
        );
      default:
        return const Text('Информация не найдена');
    }
  }

  Widget _buildRezbaInfo({
    required String radius,
    required String drillDiameter,
    required String outerDiameter,
    required String middleDiameter,
    required String innerDiameter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Радиус резьбофрезы:', radius),
        _buildInfoRow('Стандартный шаг резьбы:', '$shagRezibi мм'),
        _buildInfoRow('Диаметр сверла под резьбу:', drillDiameter),
        _buildInfoRow('Наружный диаметр резьбы:', outerDiameter),
        _buildInfoRow('Средний диаметр резьбы:', middleDiameter),
        _buildInfoRow('Внутренний диаметр резьбы:', innerDiameter),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSizeBody,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeBody,
                color: Color(0xFF667eea),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
