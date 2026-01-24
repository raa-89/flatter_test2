// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

final colorApp = Colors.white;
final colorDivider = Colors.blueGrey[200];
// константы для текста
const double fontSizeBody = 15.0;
const double fontSizeTitle = 18.0;

const double heightImgTraub = 230.0;

const double paddingHomeConteiner = 20;

const double sizedBoxHome = 10;

const double heightContainer = 505;
const double heightIconInIconBar = 28;
const double heightTextInIconBar = 20;
const double heightTooltipInIconBar = 10.0;
const double radiusAvatar = 60;
const double radiusCont = 40;

// Константы для анимации
const double drawerOpenXOffset = 290;
const double drawerOpenYOffset = 80;
const double drawerOpenScale = 0.85;
const double drawerCloseScale = 1.00;
const double drawerOpenRotation = -50.05; //-50  -0.05
const double drawerCloseRotation = 0;
const Duration animationDuration = Duration(milliseconds: 200);

//константы для скролла
const double thicknessScrollbar = 15;
const double radiusScrollbar = 10;

//расстояние сверху до ninle и иконки меню
// ignore: constant_identifier_names
const double standing_up_to_uppbar = 55;

//скругление бордера в макросах
const double cirkulRadiusCont = 25;

//размер иконок меню
const double iconSizeDrawer = 30.0;

//разница при свайпе для открытия/закрытия drawer
const double deltaDx = 2.8;

class HomeConst {
  HomeConst._();
  static const double paddingOnHomeWithContainersHorizontsl = 2;
  static const double heightContainer = 100.0;
  static const double widthContainer = 150.0;
}

class PagesConstants {
  PagesConstants._instance();
  static const String nameCodeGkod = 'G - kod';
  static const String nameCodeMkod = 'M - kod';
  static const String nameCodeMacros = 'Macros';
  //заголовк страниц
  static const String titleHome = 'Домашний экран';
  static const String titleFanuc = 'FANUC 0i-tf plus (sowin)';
  static const String titleTraub = 'TRAUB (TX8H)';
  static const String titleSyntec = 'SYNTEC 22TB (blin)';
  static const String titleInfo = 'О приложении';

  static final Color colorBackgraundHomePages = Colors.blueGrey[50]!;
  static final Color colorBackgraundCard = Colors.white;
}

class TextConst {
  TextConst._instance();
  // константы для текста
  static const double fontSizeBody = 15.0;
  static const double fontSizeTitle = 18.0;
  static const FontWeight fontWeightBody = FontWeight.w500;
  static const Color colorIconNoFocus = Colors.black;
  static const Color colorIconInFocus = Colors.white;
}

class NavigationConstant {
  static const double heightBottonNavigator = 60;
  static final List<Color> colorBackgraundBottonNavigator = [ const Color.fromARGB(141, 33, 149, 243),
            const Color.fromARGB(185, 63, 81, 181),
            const Color.fromARGB(155, 155, 39, 176),];
}
class DopuskConst {
  static const double heightSizedBox = 8.0;
}
