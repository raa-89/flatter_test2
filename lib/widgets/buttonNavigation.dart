// ignore: file_names
import 'package:flutter/material.dart';
import 'package:test2/core/const.dart';

class NewButtonNavigation extends StatefulWidget {
  final String tooltip1;
  final String tooltip2;
  final String tooltip3;
  final Function(int) onDataChanged;
  final bool isDrawerOpen;

  const NewButtonNavigation({
    super.key,
    required this.tooltip1,
    required this.tooltip2,
    required this.tooltip3,
    required this.onDataChanged,
    required this.isDrawerOpen,
  });

  @override
  State<NewButtonNavigation> createState() => _NewButtonNavigationState();
}

class _NewButtonNavigationState extends State<NewButtonNavigation> {
  int pages = 1;

  void sendDataToParent() {
    widget.onDataChanged(pages);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.isDrawerOpen
            ? const BorderRadius.vertical(bottom: Radius.circular(radiusCont))
            : null,
        // color: Colors.transparent,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: NavigationConstant.colorBackgraundBottonNavigator,
        ),
        // color: Colors.blueGrey[50],
      ),

      height: NavigationConstant.heightBottonNavigator,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                pages = 1;
                sendDataToParent();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'G',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: heightTextInIconBar,
                    color: pages == 1
                        ? TextConst.colorIconInFocus
                        : TextConst.colorIconNoFocus,
                  ),
                ),
                Text(
                  widget.tooltip1,
                  style: TextStyle(
                    color: pages == 1
                        ? TextConst.colorIconInFocus
                        : TextConst.colorIconNoFocus,
                    fontSize: heightTooltipInIconBar,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                pages = 2;
                sendDataToParent();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'M',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: heightTextInIconBar,
                    color: pages == 2
                        ? TextConst.colorIconInFocus
                        : TextConst.colorIconNoFocus,
                  ),
                ),
                Text(
                  widget.tooltip2,
                  style: TextStyle(
                    color: pages == 2
                        ? TextConst.colorIconInFocus
                        : TextConst.colorIconNoFocus,
                    fontSize: heightTooltipInIconBar,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                pages = 3;
                sendDataToParent();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: heightIconInIconBar,
                  color: pages == 3
                      ? TextConst.colorIconInFocus
                      : TextConst.colorIconNoFocus,
                ),
                Text(
                  widget.tooltip3,
                  style: TextStyle(
                    color: pages == 3
                        ? TextConst.colorIconInFocus
                        : TextConst.colorIconNoFocus,
                    fontSize: heightTooltipInIconBar,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
