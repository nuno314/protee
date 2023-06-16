part of 'message_detail_screen.dart';

extension MessageDetailAction on _MessageDetailScreenState {
  void _blocListener(BuildContext context, MessageDetailState state) {
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetFamilyProfileEvent());
  }
}
