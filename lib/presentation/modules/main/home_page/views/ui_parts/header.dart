part of '../home_page_screen.dart';

extension HomeHeaderUI on _HomePageScreenState {
  Widget _buildHeader(HomePageState state) {
    final user = state.user;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 61, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.svg.icLogo,
                  color: themeColor.white,
                  height: 40,
                ),
                Text(
                  '${trans.welcome}, ${user?.name ?? '--'}!',
                  style: TextStyle(
                    color: themeColor.color005880,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.roleLocalized(trans) ?? '',
                  style: TextStyle(
                    color: themeColor.color005880,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: themeColor.white,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImageWrapper.avatar(
                url: user?.avatar ?? '',
                fit: BoxFit.contain,
                width: 50,
                height: 50,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
