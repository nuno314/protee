import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../extentions/extention.dart';
import '../theme/theme_color.dart';

class EmptyData extends StatelessWidget {
  final Function()? onTap;
  final String icon;
  final String? emptyMessage;

  const EmptyData({
    Key? key,
    this.onTap,
    required this.icon,
    this.emptyMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 120,
              height: 120,
              color: themeColor.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              emptyMessage ?? translate(context).noData,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
