import 'package:flutter/material.dart';

import '../../../../../theme/theme_color.dart';

class SigninBg extends StatelessWidget {
  const SigninBg({
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
    final paint = Paint()..color = themeColor.primaryColor.withOpacity(0.4);
    final paintBorder = Paint()
      ..color = themeColor.primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final paint2 = Paint()..color = themeColor.primaryColor.withOpacity(0.3);
    final paint2Border = Paint()
      ..color = themeColor.primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas
      ..drawCircle(Offset(size.width * 0.1, size.height), 200, paint)
      ..drawCircle(Offset(size.width * 0.1, size.height), 220, paintBorder)
      ..drawCircle(Offset(size.width + 50, 0), 200, paint2)
      ..drawCircle(Offset(size.width + 50, 0), 210, paint2Border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
