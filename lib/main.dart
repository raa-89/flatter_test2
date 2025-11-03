import 'package:flutter/material.dart';
import 'package:test2/widgets/routes.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}


