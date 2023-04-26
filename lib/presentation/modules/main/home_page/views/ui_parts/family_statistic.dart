part of '../home_page_screen.dart';

extension HomeFamilyStatisticUI on _HomePageScreenState {
  Widget _buildFamilyStatistic(HomePageState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _buildStatisticItem(
              title: 'Thành viên',
              number: 3,
              color: themeColor.color33B64F,
              isSelected: idx == 0,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatisticItem(
              title: 'Địa điểm',
              number: 420,
              color: themeColor.color34C5D0,
              isSelected: idx == 1,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatisticItem(
              title: 'Cảnh báo',
              number: 12,
              color: themeColor.colorFA3D0C,
              isSelected: idx == 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem({
    required String title,
    required int number,
    bool isSelected = false,
    Color? color,
  }) {
    final selectedColor = isSelected ? color! : themeColor.white;
    final defaultColor = isSelected ? themeColor.white : color!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.fromLTRB(8, isSelected ? 28 : 8, 8, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              color: defaultColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
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
