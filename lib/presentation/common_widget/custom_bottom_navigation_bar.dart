import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../theme/shadow.dart';
import '../theme/theme_color.dart';
import 'smart_image.dart';

class BottomBarItemData {
  /// [icon] supported [String, IconData, Widget]
  final dynamic icon;

  /// [selectedIcon] supported [String, IconData, Widget, NULL]
  final dynamic selectedIcon;
  final bool? isOver;
  final int? badgeCount;

  BottomBarItemData({
    this.icon,
    this.selectedIcon,
    this.isOver,
    this.badgeCount,
  });
}

class CustomBottomNavigationBar extends StatefulWidget {
  final Future<bool> Function(int)? onItemSelection;
  final int? selectedIdx;
  final List<BottomBarItemData>? items;

  const CustomBottomNavigationBar({
    Key? key,
    this.onItemSelection,
    this.selectedIdx = 0,
    this.items,
  }) : super(key: key);
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late ValueNotifier<int?> idxNotifier;

  @override
  void initState() {
    idxNotifier = ValueNotifier(widget.selectedIdx);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    idxNotifier.value = widget.selectedIdx;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    idxNotifier = ValueNotifier(widget.selectedIdx);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    idxNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ValueListenableBuilder<int?>(
          valueListenable: idxNotifier,
          builder: (ctx, value, w) {
            final itemWidth =
                (constraints.maxWidth - 32) / widget.items!.length;
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: boxShadowlight,
                    color: themeColor.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items!.mapIndex<Widget>((item, idx) {
                      if (item.isOver == true) {
                        return SizedBox(width: itemWidth);
                      }
                      return SizedBox(
                        width: itemWidth,
                        child: BottomItem(
                          item: item,
                          onPressed: () async {
                            if (idx != value &&
                                await widget.onItemSelection?.call(idx) ==
                                    true) {
                              idxNotifier.value = idx;
                            }
                          },
                          selected: idx == value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Row(
                    children: widget.items!.mapIndex<Widget>((item, idx) {
                      if (item.isOver != true) {
                        return SizedBox(width: itemWidth);
                      }
                      return SizedBox(
                        width: itemWidth,
                        child: BottomItem(
                          item: item,
                          iconSize: itemWidth * 0.9,
                          onPressed: () async {
                            if (idx != value &&
                                await widget.onItemSelection?.call(idx) ==
                                    true) {
                              idxNotifier.value = idx;
                            }
                          },
                          selected: idx == value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CurvedShape(),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class BottomItem extends StatelessWidget {
  final BottomBarItemData item;
  final void Function()? onPressed;
  final bool selected;
  final double iconSize;

  const BottomItem({
    Key? key,
    required this.item,
    this.onPressed,
    this.selected = false,
    this.iconSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(
      item.icon is String || item.icon is IconData || item.icon is Widget,
      'BottomBarItemData.icon supported [String, IconData, Widget]',
    );
    assert(
      item.selectedIcon == null ||
          item.selectedIcon is String ||
          item.selectedIcon is IconData ||
          item.selectedIcon is Widget,
      '''BottomBarItemData.selectedIcon supported [String, IconData, Widget, NULL]''',
    );
    final count = item.badgeCount ?? 0;
    final theme = context.theme;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            badges.Badge(
              showBadge: count > 0,
              badgeContent: Text(
                '${min(count, 99)}${count > 99 ? '+' : ''}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              badgeAnimation: const badges.BadgeAnimation.scale(
                toAnimate: true,
                animationDuration: Duration(milliseconds: 250),
              ),
              badgeStyle: badges.BadgeStyle(
                padding: EdgeInsets.all(count > 9 ? 3 : 5),
                shape: badges.BadgeShape.circle,
              ),
              child: _buildIcon(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final icon =
        (selected == true ? item.selectedIcon : item.icon) ?? item.icon;
    if (icon is Widget) {
      return icon;
    }
    if (icon is IconData) {
      return Icon(
        icon,
        size: iconSize,
        color: selected ? themeColor.primaryColor : Colors.grey,
      );
    }
    if (icon is! String) {
      return const SizedBox();
    }
    return SmartImage(
      image: icon,
      width: iconSize,
      height: iconSize,
      fit: BoxFit.cover,
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height / 2)
      ..arcToPoint(
        Offset(size.width, size.height / 2),
        radius: Radius.circular(size.width / 2),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvedShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _MyPainter(),
      ),
    );
  }
}

const CURVE_HEIGHT = 160.0;
const AVATAR_RADIUS = CURVE_HEIGHT * 0.1;
const AVATAR_DIAMETER = AVATAR_RADIUS * 0.1;

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = themeColor.primaryColor;

    final circleCenter = Offset(size.width / 2, size.height - AVATAR_RADIUS);

    const topLeft = Offset(0, 0);
    final bottomLeft = Offset(0, size.height * 0.5);
    final topRight = Offset(size.width, 0);
    final bottomRight = Offset(size.width, size.height * 0.5);

    final leftCurveControlPoint =
        Offset(circleCenter.dx * 0.5, size.height - AVATAR_RADIUS * 1.5);
    final rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - AVATAR_RADIUS);

    const arcStartAngle = 200 / 180 * pi;
    final avatarLeftPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcStartAngle);
    final avatarLeftPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcStartAngle);
    final avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    const arcEndAngle = -5 / 180 * pi;
    final avatarRightPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcEndAngle);
    final avatarRightPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcEndAngle);
    final avatarRightPoint = Offset(
      avatarRightPointX,
      avatarRightPointY,
    ); // the right point of the arc

    final path = Path()
      ..moveTo(
        topLeft.dx,
        topLeft.dy,
      ) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..lineTo(
        leftCurveControlPoint.dx,
        leftCurveControlPoint.dy,
      )
      ..arcToPoint(
        avatarRightPoint,
        radius: const Radius.circular(AVATAR_RADIUS),
      )
      // ..quadraticBezierTo(
      //   rightCurveControlPoint.dx,
      //   rightCurveControlPoint.dy,
      //   bottomRight.dx,
      //   bottomRight.dy,
      // )
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
