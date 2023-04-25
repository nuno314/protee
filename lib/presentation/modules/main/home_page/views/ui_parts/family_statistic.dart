part of '../home_page_screen.dart';

extension HomeFamilyStatisticUI on _HomePageScreenState {
  Widget _buildFamilyStatistic(HomePageState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Wrap(children: [
        _buildStatisticItem(title: '', number: 0),
      ]),
    );
  }

  Widget _buildStatisticItem({
    required String title,
    required int number,
    Color? color,
  }) {
    return BoxColor(
      color: color ?? themeColor.gray8C,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
