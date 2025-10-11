import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';

class TraubMacros extends StatelessWidget {
  const TraubMacros({super.key});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: sizedBoxHome, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'G86 Цикл глубокого сверления',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),
                Text(
                  'G86 X.. D.. H.. F..',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),

                Text('''где:
X - глубина сверления;
D - глубина первого засверливания;
H - количество проходов;
F - рабочая подача.''', style: TextStyle(fontSize: fontSizeBody)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: sizedBoxHome, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Макрос канавки',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                Text(
                  'G204 A.. B.. C.. D.. E.. F.. H.. I.. J.. K.. M.. R..',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                Center(
                  child: Image.asset('assets/img/kanavka.png', height: 180),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text('''Где:
A - начальная верхняя точка по Х;
B - угол фаски слева;
C - скругление внутри канавки слева;
D - диаметр канавки;
E - скругление внутри канавки справа;
F - угол фаски справа;
H - конечная верхняя точка по Х;
I - ширина канавки;
J - конечная точка канавки по Z;
K - ширина канавочной пласины;
M - радиус канавочной пластины;
R - рабочая подача.''', style: TextStyle(fontSize: fontSizeBody)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewTextSeparated extends StatelessWidget {
  final String data;
  const NewTextSeparated({super.key, required this.data});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data, style: TextStyle(fontSize: fontSizeBody)),
        Divider(),
      ],
    );
  }
}
