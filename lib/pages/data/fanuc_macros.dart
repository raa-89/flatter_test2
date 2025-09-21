import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';

class FanucMacros extends StatelessWidget {
  const FanucMacros({super.key});
  // Метод build описывает пользовательский интерфейс
  @override
  Widget build(BuildContext context) {
    return Container(
       height: 505,
      margin: EdgeInsets.symmetric(horizontal: sizedBoxHome),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHomeConteiner,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вкл./Откл. вращения шпинделей',
            style: TextStyle(fontSize: fontSizeTitle),
          ),
          Divider(),
          Image.asset('assets/img/sowin.jpg'),
          SizedBox(height: sizedBoxHome),
          Text(
            'Направление вращения шпинделей:',
            style: TextStyle(fontSize: fontSizeBody),
          ),
          NewTextSeparated(data: 'М03 ГШП по часовой стрелке (вправо)'),
          NewTextSeparated(data: 'М04 ГШП против часовой стрелке (влево)'),
          NewTextSeparated(data: 'М05 Останов шпинделя'),
          NewTextSeparated(
            data: 'М03 Вращение противошпинделя против часовой стрелки',
          ),
          Text(
            'М105 Остановка вращения шпинделя',
            style: TextStyle(fontSize: fontSizeBody),
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
