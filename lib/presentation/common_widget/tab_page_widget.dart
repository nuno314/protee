import 'package:flutter/material.dart';

import '../../common/utils.dart';
import 'after_layout.dart';

class TabBox extends StatelessWidget {
  final Widget? child;
  const TabBox({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.04, 0.04],
          colors: [Colors.black.withOpacity(0.05), Colors.white],
        ),
      ),
      child: child,
    );
  }
}

class TabPageWidget extends StatefulWidget {
  final Tab Function(BuildContext context, int index) tabBuilder;
  final Widget Function(BuildContext context, int index) pageBuilder;
  final int length;
  final void Function(
    TabController tabController,
    PageController pageController,
  )? onViewCreated;
  final ScrollPhysics? physics;
  final bool isTabScrollable;
  final Color? pageBackground;
  final bool allowImplicitScrolling;
  final PageController? pageController;
  final void Function(int)? onPageChanged;
  final int initialIndex;

  const TabPageWidget({
    Key? key,
    required this.tabBuilder,
    required this.pageBuilder,
    required this.length,
    this.onViewCreated,
    this.isTabScrollable = false,
    this.allowImplicitScrolling = false,
    this.physics,
    this.pageBackground,
    this.pageController,
    this.onPageChanged,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<TabPageWidget> createState() => _TabPageWidgetState();
}

class _TabPageWidgetState extends State<TabPageWidget> with AfterLayoutMixin {
  late final _pageController = PageController(
    initialPage: widget.initialIndex,
  );

  TabController? tabController;

  PageController get pageController => widget.pageController ?? _pageController;

  void onDefaultTabCreated(BuildContext context) {
    DefaultTabController.of(context).let((it) {
      tabController = it;
      widget.onViewCreated?.call(
        tabController!,
        pageController,
      );
    });
  }

  late final debouncer = Debouncer<int>(
    const Duration(milliseconds: 100),
    onPageChanged,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BuildContext? _defaultTabContext;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: widget.length,
      child: Builder(
        builder: (defaultTabContext) {
          _defaultTabContext = defaultTabContext;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TabBox(
                child: TabBar(
                  onTap: (index) => pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  ),
                  isScrollable: widget.isTabScrollable,
                  tabs: [
                    ...List.generate(
                      widget.length,
                      (index) => widget.tabBuilder(context, index),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: widget.pageBackground,
                  child: PageView.builder(
                    controller: pageController,
                    physics: widget.physics ?? const BouncingScrollPhysics(),
                    allowImplicitScrolling: widget.allowImplicitScrolling,
                    onPageChanged: (value) {
                      debouncer.value = value;
                    },
                    itemBuilder: widget.pageBuilder,
                    itemCount: widget.length,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _defaultTabContext?.let(onDefaultTabCreated);
    pageController.jumpToPage(widget.initialIndex);
  }

  void onPageChanged(int? value) {
    if (value != null) {
      tabController?.animateTo(value);
      widget.onPageChanged?.call(value);
    }
  }
}
