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
            margin: const EdgeInsets.symmetric(
              horizontal: sizedBoxHome,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
            margin: const EdgeInsets.symmetric(
              horizontal: sizedBoxHome,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Макрос канавки',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                const Divider(),
                const Text(
                  'G204 A.. B.. C.. D.. E.. F.. H.. I.. J.. K.. M.. R..',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                const Divider(),
                Center(
                  child: Image.asset('assets/img/kanavka.png', height: 180),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: const Text('''Где:
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: sizedBoxHome, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Нарезание наружней резьбы',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),
                Text(
                  'G76 X.. Z.. I.. J.. K.. H.. F.. A57 D..;',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),

                Text(
                  '''где:
X, Z - координаты по соответсвующей оси;
I - наклон при конической резьбе, мм.;
J - угол при конической резьбе;
K - начальное расстояние между заготовкой и резцом (0,6 * шаг резьбы);
H - количество проходов;
F - шаг резьбы;
D - глубина резания последнего прохода.''',
                  style: TextStyle(fontSize: fontSizeBody),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: sizedBoxHome, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(cirkulRadiusCont),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: paddingHomeConteiner,
              vertical: 8.0,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Резьбофрезерование',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),
                Text(
                  'G337 F.. M.. P.. X.. Y.. Z..;',
                  style: TextStyle(fontSize: fontSizeTitle),
                ),
                Divider(),
                SizedBox(height: sizedBoxHome),

                Text(
                  '''где:
X, Y, Z - координаты по соответсвующей оси;
F - подача;
M - номинальный диаметр резьбы;
P - шаг резьбы.
  Сумма начального положения фрезы по Z перед макросом резьбофрезерования с конечным положением после нарезания резьбы (Z) должна делиться на цело на шаг резьбы.
  При переходе на полнопроходную резьбофрезу необходимо поменять последнее перемещение G0 перед резьбофрезерованием примерно на 2 витка в сторону заготовки и снизить подачу примерно до F20.''',
                  style: TextStyle(fontSize: fontSizeBody),
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
        Text(data, style: const TextStyle(fontSize: fontSizeBody)),
        const Divider(),
      ],
    );
  }
}
