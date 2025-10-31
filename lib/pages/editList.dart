import 'package:flutter/material.dart';
import 'package:test2/pages/const.dart';

class Editlist extends StatefulWidget {
  final String dataFromList;
  const Editlist({super.key, required this.dataFromList});

  @override
  State<Editlist> createState() => EditlistState();
}

class EditlistState extends State<Editlist> {
  String get _dataFromList => widget.dataFromList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Заголовок
                  SizedBox(
                    height: standing_up_to_uppbar,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: iconSizeDrawer,
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                          // Expanded(
                          // child: Center(
                          //   child: Text(
                          //     _dataFromList,
                          //     style: TextStyle(fontSize: fontSizeTitle),
                          //   ),
                          // ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // Основной контент (занимает все доступное пространство)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _dataFromList,
                        style: TextStyle(fontSize: fontSizeTitle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClass {
   MyClass();
}

void myMethod() {
   MyClass();
}
