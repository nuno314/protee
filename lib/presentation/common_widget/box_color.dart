import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

class BoxColor extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  const BoxColor({
    Key? key,
    required this.color,
    required this.borderRadius,
    this.child,
    this.padding = const EdgeInsets.fromLTRB(6, 4, 6, 4),
    this.margin,
    this.border,
    this.constraints,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}

class HighlightBoxColor extends StatelessWidget {
  final Widget? child;
  final Color bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final void Function()? onTap;
  final BorderRadius? borderRadius;
  final double? borderWidth;

  const HighlightBoxColor({
    Key? key,
    this.child,
    this.margin,
    this.padding = const EdgeInsets.all(8),
    this.bgColor = Colors.white,
    this.borderColor,
    this.constraints,
    this.alignment,
    this.onTap,
    this.borderRadius,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius =
        borderRadius ?? const BorderRadius.all(Radius.circular(8));
    final _borderWidth = borderWidth ?? 1;
    return InkWell(
      onTap: onTap,
      borderRadius: _borderRadius,
      child: BoxColor(
        padding: padding,
        color: bgColor,
        constraints: constraints,
        alignment: alignment,
        borderRadius: _borderRadius,
        margin: margin,
        border: Border.all(
          color: borderColor ?? themeColor.primaryColor,
          width: _borderWidth,
        ),
        child: child,
      ),
    );
  }
}

class ChipItem extends StatelessWidget {
  final bool selected;
  final String text;
  final void Function(bool selected)? onTap;
  final TextTheme textTheme;
  final BoxConstraints? constraints;
  final Color bgColor;

  const ChipItem({
    Key? key,
    required this.selected,
    required this.text,
    required this.textTheme,
    this.onTap,
    this.constraints = const BoxConstraints(minWidth: 80),
    this.bgColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => onTap?.call(selected),
      child: BoxColor(
        constraints: constraints,
        color: selected ? themeColor.primaryColorLight : bgColor,
        borderRadius: BorderRadius.circular(32),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        border: Border.all(
          width: 1,
          color: selected ? themeColor.primaryColor : Colors.grey,
        ),
        child: Text(
          text,
          style: selected
              ? textTheme.bodyLarge
                  ?.copyWith(color: themeColor.primaryColor)
              : textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
