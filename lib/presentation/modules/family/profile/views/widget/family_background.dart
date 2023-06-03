import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class FamilyProfileBackground extends StatelessWidget {
  const FamilyProfileBackground({
    Key? key,
    required this.screenSize,
    this.color,
  }) : super(key: key);

  final Color? color;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LoginBgPainter(),
      size: Size(screenSize.width, screenSize.height),
    );
  }
}

class LoginBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        [
          const Color(0xFF7C84F8),
          const Color(0xFFAC7CF8).withOpacity(0.5),
        ],
      );
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.2,
        size.width,
        size.height * 0.3,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
