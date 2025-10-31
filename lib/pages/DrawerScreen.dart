// ignore: file_names
import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';
import 'package:test2/pages/routes.dart';

class Drawerscreen extends StatefulWidget {
  final Function() drawerClose;
  const Drawerscreen({super.key, required this.drawerClose});

  @override
  State<Drawerscreen> createState() => _DrawerscreenState();
}

class _DrawerscreenState extends State<Drawerscreen> {
  static const String title1 = titleHome;
  static const String title2 = titleFanuc;
  static const String title3 = titleTraub;
  // static const String title5 = titleSyntec;
  // static const String title4 = titleInfo;

  void sentCloseDrawer() => widget.drawerClose();

  @override
  Widget build(BuildContext context) {
    //построение изменяемого виджета
    return SafeArea(
      child: Container(
        color: Colors.blueGrey[500],
        padding: EdgeInsets.only(top: 50, left: 20, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img/kot.jpg'),
                  radius: radiusAvatar,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 30),
                ItemMenu(
                  labelText: title1,
                  iconWidget: Icons.home,
                  routes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.home,
                      arguments: title1,
                    );
                    sentCloseDrawer();
                  },
                ),
                ItemMenu(
                  labelText: title2,
                  iconWidget:  Icons.dashboard_sharp,
                  routes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.fanuc,
                      arguments: title2,
                    );
                    sentCloseDrawer();
                  },
                ),
                ItemMenu(
                  labelText: title3,
                  iconWidget: Icons.dashboard_sharp,
                  routes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.traub,
                      arguments: title3,
                    );
                    sentCloseDrawer();
                  },
                ),
                /*   ItemMenu(
                  labelText: title5,
                  iconWidget: Icons.dashboard_sharp,
                  routes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.syntec,
                      arguments: title5,
                    );
                  },
                ), */

                /* ItemMenu(
                  labelText: title4,
                  iconWidget: Icons.info_outline_rounded,
                  routes: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.info,
                      arguments: title4,
                    );
                  },
                ), */
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                TextButton.icon(
                  // onPressed: () => _homePagesStateNew?.closeDrawer(),
                  onPressed: () => sentCloseDrawer(),
                  label: const Text(
                    'закрыть',
                    style: TextStyle(color: Colors.white54),
                  ),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final String labelText;
  final IconData iconWidget;
  final Function() routes;
  const ItemMenu({
    super.key,
    required this.labelText,
    required this.iconWidget,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            // Navigator.pushNamed(context, AppRoutes.home);
            routes();
            // Navigator.pop(context);
          },
          icon: Icon(iconWidget, color: Colors.white),
          label: Text(labelText, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
