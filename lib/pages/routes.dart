import 'package:flutter/cupertino.dart';
import 'package:test2/pages/fanuc.dart';
import 'package:test2/pages/home.dart';
import 'package:test2/pages/info.dart';
import 'package:test2/pages/syntec.dart';
import 'package:test2/pages/traub.dart';

class AppRoutes {
  static const String home = '/home';
  static const String traub = '/traub';
  static const String info = '/info';
  static const String fanuc = '/fanuc';
  static const String syntec = '/syntec';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      home: (context) => homePages(),
      fanuc: (context) => BodyFanuc(),
      traub: (context) => BodyTraub(),
      info: (context) => InfoPages(),
      syntec: (context) => BodySyntec(),
    };
  }
}
