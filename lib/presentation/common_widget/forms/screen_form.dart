import 'package:flutter/material.dart';

import '../../../common/utils.dart';

class ScreenForm extends StatefulWidget {
  final String? title;
  final String? des;
  final Widget? child;
  final Color? bgColor;
  final Color? headerColor;
  final List<Widget> actions;
  final void Function()? onBack;
  final bool? resizeToAvoidBottomInset;
  final Widget? extentions;
  final bool showBackButton;

  const ScreenForm({
    Key? key,
    this.title,
    this.des,
    this.child,
    this.bgColor,
    this.actions = const <Widget>[],
    this.headerColor,
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.extentions,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  _ScreenFormState createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final padding = mediaQueryData.padding;

    final main = Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: padding.top + 16),
          color: widget.headerColor ?? Colors.transparent,
          child: _buildAppBar(),
        ),
        Expanded(
          child: widget.child ?? const SizedBox(),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: widget.bgColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: GestureDetector(
        onTap: () => CommonFunction.hideKeyBoard(context),
        child: main,
      ),
    );
  }

  Widget _buildAppBar() {
    const textColor = Colors.black;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: widget.showBackButton ? 4 : 16),
            if (widget.showBackButton)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: IconButton(
                  onPressed: widget.onBack ?? () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.chevron_left_outlined,
                    size: 18,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: widget.actions.isEmpty ? 24 : 8,
                  top: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.title ?? '',
                      style: _theme.textTheme.displaySmall?.copyWith(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    if (widget.des?.isNotEmpty == true)
                      const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            ...widget.actions,
          ],
        ),
        if (widget.extentions != null) widget.extentions!,
        const SizedBox(height: 16),
      ],
    );
  }
}
