part of '../home_page_screen.dart';

extension HomeFamilyStatisticUI on _HomePageScreenState {
  Widget _buildFamilyStatistic(HomePageState state) {
    return ValueListenableBuilder<int>(
      valueListenable: _idxNotifier,
      builder: (context, value, child) => Container(
        height: 163,
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildStatisticItem(
                title: trans.member,
                number: 3,
                color: themeColor.color33B64F,
                isSelected: value == 0,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatisticItem(
                title: trans.locations,
                number: 420,
                color: themeColor.colorFF960C,
                isSelected: value == 1,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatisticItem(
                title: trans.warnings,
                number: 12,
                color: themeColor.colorFA3D0C,
                isSelected: value == 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem({
    required String title,
    required int number,
    bool isSelected = false,
    Color? color,
  }) {
    final selectedColor =
        isSelected ? themeColor.color34C5D0 : themeColor.white;
    final defaultColor = isSelected ? themeColor.white : color!;

    return AnimatedContainer(
      height: isSelected ? 140 : 87,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
      decoration: BoxDecoration(
        boxShadow: isSelected
            ? [
                const BoxShadow(
                  color: Color.fromRGBO(0, 150, 178, 0.4),
                  offset: Offset(0, 4),
                  blurRadius: 16,
                )
              ]
            : boxShadowlightest,
        color: selectedColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.fromLTRB(12, isSelected ? 28 : 8, 8, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              color: defaultColor,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: defaultColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
