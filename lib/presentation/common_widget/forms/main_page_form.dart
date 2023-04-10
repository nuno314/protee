import 'dart:math';

import 'package:flutter/material.dart';

import '../../../common/utils.dart';
import '../../theme/shadow.dart';

class MainPageForm extends StatelessWidget {
  final Widget? body;
  final String? title;
  final List<Widget>? actions;
  final Widget? extention;
  final Color? bgColor;
  final Widget? floatingActionButton;
  final bool showHeaderShadow;
  final bool showAppbarDivider;
  final Color? appbarColor;
  final Color? appbarSecondaryColor;
  final bool hasBorder;
  final int? titleMaxLines;
  final bool? resizeToAvoidBottomInset;

  const MainPageForm({
    Key? key,
    this.body,
    this.title,
    this.actions,
    this.extention,
    this.floatingActionButton,
    this.bgColor,
    this.showHeaderShadow = true,
    this.showAppbarDivider = false,
    this.appbarColor,
    this.appbarSecondaryColor,
    this.hasBorder = true,
    this.titleMaxLines,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          _buildAppBar(context),
          if (showAppbarDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[200],
            ),
          Expanded(child: body ?? const SizedBox()),
        ],
      ),
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final theme = context.theme;
    return ClipRRect(
      borderRadius: hasBorder
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )
          : BorderRadius.zero,
      child: Container(
        width: double.infinity,
        decoration: appbarColor == Colors.transparent
            ? null
            : BoxDecoration(
                boxShadow: showHeaderShadow ? boxShadowlight : null,
                color: appbarColor,
              ),
        child: Column(
          children: [
            SizedBox(
              height: max(
                mediaData.padding.top,
                24,
              ),
            ),
            if (title != null || actions != null)
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Text(
                      title ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appbarSecondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 16),
                        ...actions ?? const <Widget>[],
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            extention ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
