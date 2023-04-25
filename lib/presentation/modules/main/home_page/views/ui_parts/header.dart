part of '../home_page_screen.dart';

extension HomeHeaderUI on _HomePageScreenState {
  Widget _buildHeader(HomePageState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child:
                CachedNetworkImageWrapper.avatar(url: state.user?.avatar ?? ''),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chào mừng',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                state.user?.name ?? '--',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
