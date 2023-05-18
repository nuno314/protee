import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../theme/shadow.dart';
import '../theme/theme_color.dart';
import 'item_devider.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Widget icon;
  final Color? color;
  final ItemDivider? divider;
  final ItemBorder itemBorder;
  final EdgeInsets padding;
  final Widget? tailIcon;
  final Widget? description;

  const MenuItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.divider,
    this.itemBorder = ItemBorder.none,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.tailIcon,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadius;
    switch (itemBorder) {
      case ItemBorder.all:
        borderRadius = BorderRadius.circular(8);
        break;
      case ItemBorder.top:
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        );

        break;
      case ItemBorder.bottom:
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        );

        break;
      default:
    }
    final bgColor = color ?? Colors.white;
    return Padding(
      padding: EdgeInsets.only(
        bottom: divider != ItemDivider.space ? 0 : 16,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            child: Container(
              padding: EdgeInsets.only(
                top: padding.top,
                bottom: padding.bottom,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                boxShadow: boxShadowlightest,
                borderRadius: borderRadius,
                gradient: divider == ItemDivider.line &&
                        itemBorder != ItemBorder.bottom &&
                        itemBorder != ItemBorder.all
                    ? LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.01, 0.01],
                        colors: [Colors.grey, bgColor],
                      )
                    : null,
              ),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: themeColor.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: description!,
                    ),
                  if (tailIcon != null) tailIcon!,
                  if (onTap != null && tailIcon == null)
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: Colors.grey,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
