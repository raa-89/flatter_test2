import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';

class FanucMacros extends StatelessWidget {
  const FanucMacros({super.key});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: sizedBoxHome),
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
              'Вкл./Откл. вращения шпинделей',
              style: TextStyle(fontSize: fontSizeTitle),
            ),
            const Divider(),
            Image.asset('assets/img/sowin.jpg'),
            const SizedBox(height: sizedBoxHome),
            const Text(
              'Направление вращения шпинделей:',
              style: TextStyle(fontSize: fontSizeBody),
            ),
            const NewTextSeparated(data: 'М03 ГШП по часовой стрелке (вправо)'),
            const NewTextSeparated(data: 'М04 ГШП против часовой стрелке (влево)'),
            const NewTextSeparated(data: 'М05 Останов шпинделя'),
            const NewTextSeparated(
              data: 'М03 Вращение противошпинделя против часовой стрелки',
            ),
            const Text(
              'М105 Остановка вращения шпинделя',
              style: TextStyle(fontSize: fontSizeBody),
            ),
          ],
        ),
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
