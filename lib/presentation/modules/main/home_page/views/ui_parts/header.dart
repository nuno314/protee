part of '../home_page_screen.dart';

extension HomeHeaderUI on _HomePageScreenState {
  Widget _buildHeader(HomePageState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 61, 16, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.svg.icLogo,
                color: themeColor.white,
                height: 40,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Xin chào, ${state.user?.name ?? '--'}',
                style: TextStyle(
                  color: themeColor.color005880,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: themeColor.white,
              ),
            ),
            child: CachedNetworkImageWrapper.avatar(
              url: state.user?.avatar ?? '',
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
