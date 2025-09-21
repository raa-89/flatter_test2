import 'package:flutter/cupertino.dart';
import 'package:test2/pages/data/fanuc_g.dart' show fanuc_G_kod;
import 'package:test2/pages/fanuc.dart';
import 'package:test2/pages/home.dart';

class AppRoutes {
  static const String home = '/home';

  static const String fanucMacros = '/fanuc/Macros';
  static const String traubM = '/traub/M';
  static const String traubG = '/traub/G';
  static const String traubMacros = '/traub/macros';
  static const String info = '/info';
  static const String fanuc = '/fanuc';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      home: (context) => homePages(),

      fanucMacros: (context) => fanuc_G_kod(),
      traubM: (context) => homePages(),
      traubG: (context) => fanuc_G_kod(),
      traubMacros: (context) => homePages(),
      info: (context) => fanuc_G_kod(),
      fanuc: (context) => BodyFanuc(),
    };
  }
}
