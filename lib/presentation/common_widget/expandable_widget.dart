import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

export 'package:expandable/expandable.dart';

class ExpandableWidget extends StatefulWidget {
  final Widget header;
  final Widget body;
  final Widget? divider;
  final TextTheme textTheme;
  final ExpandableController? controller;
  final void Function()? onTapHeader;
  final bool toggleCtrWhenTapHeader;

  const ExpandableWidget({
    Key? key,
    this.controller,
    required this.header,
    required this.body,
    required this.textTheme,
    this.onTapHeader,
    this.divider,
    this.toggleCtrWhenTapHeader = true,
  }) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  TextTheme get textTheme => widget.textTheme;

  ExpandableController? _controller;

  @override
  void initState() {
    _controller = widget.controller ?? ExpandableController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpandableWidget oldWidget) {
    _controller = widget.controller ?? _controller ?? ExpandableController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  Widget _buildHeader() {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        widget.onTapHeader?.call();
        if (widget.toggleCtrWhenTapHeader) {
          _controller!.toggle();
        }
      },
      child: widget.header,
    );
  }

  Widget _buildExpanded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        widget.divider ?? const SizedBox(),
        widget.body,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _controller,
      child: Expandable(
        collapsed: _buildHeader(),
        expanded: _buildExpanded(),
      ),
    );
  }
}
