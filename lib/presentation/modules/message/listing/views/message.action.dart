part of 'message_screen.dart';

extension MessageAction on _MessageScreenState {
  void _blocListener(BuildContext context, MessageState state) {
    hideLoading();
    // Future.delayed(const Duration(milliseconds: 200), () async {
    //   await _scrollDown();
    // });

    if (state is SendMessageState) {}
  }

  void _onRefresh() {
    bloc.add(GetMessagesEvent());
  }

  void _onLoading() {
    bloc.add(LoadMoreMessagesEvent());
  }

  void _sendMessage() {
    _scrollDown();
    if (_icChat.text.isNullOrEmpty) {
      return;
    }
    bloc.add(SendMessageEvent(_icChat.text.trim()));
    _icChat.clear();
  }

  Future<void> _scrollDown() async {
    await _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }
}
