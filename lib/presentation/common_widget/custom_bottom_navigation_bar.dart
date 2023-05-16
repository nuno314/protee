import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../common/utils.dart';
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
                    color: themeColor.white,
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
