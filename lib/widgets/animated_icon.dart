// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyAnimatedIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  const MyAnimatedIcon({super.key, required this.icon, required this.color});

  @override
  State<MyAnimatedIcon> createState() => _MyAnimatedIconState();
}

class _MyAnimatedIconState extends State<MyAnimatedIcon>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    //инициализация переменых
    super.initState();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 2),
    // )..repeat();
  }

  @override
  void dispose() {
    // Очистка ресурсов
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //построение изменяемого виджета
    return RotationTransition(
      turns: _animation,
      child: Icon(widget.icon, size: 40, color: widget.color),
    );
  }
}
