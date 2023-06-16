import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../theme/theme_color.dart';
import 'loading.dart';

export 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
export 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    show RefreshController;

class SmartRefresherWrapper extends StatelessWidget {
  const SmartRefresherWrapper({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
    this.scrollController,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.color,
    this.reverse,
  });

  final RefreshController controller;
  final bool enablePullDown;
  final bool enablePullUp;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? child;
  final ScrollController? scrollController;
  final Color? color;
  final bool? reverse;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      header: MaterialClassicHeader(
        backgroundColor: color ?? themeColor.primaryColor,
      ),
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      scrollController: scrollController,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          return const Align(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Loading(
                brightness: Brightness.light,
                radius: 10,
              ),
            ),
          );
        },
      ),
      reverse: reverse,
      child: child,
    );
  }
}
