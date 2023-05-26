import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/shadow.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: boxShadowlight,
      ),
      padding: EdgeInsets.only(
        bottom: max(paddingBottom, 16),
        right: 16,
        left: 16,
        top: 16,
      ),
      child: child,
    );
  }
}
