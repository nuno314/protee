import 'package:flutter/material.dart';

class HomePageBackground extends StatelessWidget {
  const HomePageBackground({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

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
    final paint = Paint()..color = const Color(0xff0097B2).withOpacity(0.2);

    canvas.drawOval(
      Rect.fromCenter(center: const Offset(95, 15), width: 362, height: 356),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
