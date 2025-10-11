import 'package:flutter/material.dart';
import 'package:test2/pages/routes.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

/* void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      /* home: Scaffold(body: Stack(children: [Drawerscreen(), homePages()])), */
      // home: Scaffold(body: homePages()),
    );
  }
} */
