import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/message.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/footer_widget.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/message_bloc.dart';

part 'message.action.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends StateBase<MessageScreen> {
  final _refreshController = RefreshController(initialRefresh: true);
  final _icChat = InputContainerController();
  final ScrollController _controller = ScrollController();

  @override
  MessageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void hideLoading() {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();

    super.hideLoading();
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<MessageBloc, MessageState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          title: trans.message,
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          bgColor: themeColor.white,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //     child: InkWell(
          //       onTap: _onTapChatInfo,
          //       child: SvgPicture.asset(
          //         Assets.svg.icGroup,
          //         color: themeColor.white,
          //       ),
          //     ),
          //   ),
          // ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildMessageBox(state)),
              FooterWidget(
                child: _buildCommentBox(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBox(MessageState state) {
    final messages = state.messages;

    return SmartRefresherWrapper(
      reverse: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: false,
      onLoading: _onLoading,
      enablePullUp: state.canLoadMore,
      child: messages.isEmpty
          ? const SizedBox()
          : ListView.separated(
              controller: _controller,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index) {
                final message = messages.elementAt(index);

                Message? next;
                if (index == messages.length - 1) {
                  next = null;
                } else {
                  next = messages.elementAt(index + 1);
                }

                Message? prev;
                if (index == 0) {
                  prev = null;
                } else {
                  prev = messages.elementAt(index - 1);
                }
                var item = [
                  _buildMessage(
                    message,
                    showAvatar: prev == null ||
                        (prev.createdAt!
                            .add(const Duration(minutes: 30))
                            .isBefore(message.createdAt!)) ||
                        (message.user?.id != prev.user?.id),
                  ),
                ];
                if (prev == null ||
                    prev.createdAt!
                        .add(const Duration(minutes: 30))
                        .isBefore(message.createdAt!)) {
                  item = [
                    Text(
                      message.createdAt?.toLocalHHnnddmmyyyy() ?? '--',
                      style: TextStyle(fontSize: 12, color: themeColor.gray8C),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    ...item,
                  ];
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: item,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: messages.length,
            ),
    );
  }

  Widget _buildCommentBox() {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      child: Row(
        children: [
          Expanded(
            child: InputContainer(
              fillColor: themeColor.greyDC.withOpacity(0.2),
              controller: _icChat,
              borderRadius: BorderRadius.circular(24),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 4),
            child: InkWell(
              onTap: _sendMessage,
              child: SvgPicture.asset(
                Assets.svg.icSend,
                width: 30,
                height: 30,
                color: themeColor.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessage(Message message, {bool showAvatar = false}) {
    final isSender = message.user?.id == bloc.state.user?.id;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (!isSender && showAvatar)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImageWrapper.avatar(
                  url: message.user?.avatar ?? '',
                  width: 30,
                  height: 30,
                ),
              )
            : const SizedBox(width: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Align(
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isSender
                    ? themeColor.primaryColor.withOpacity(0.2)
                    : themeColor.greyDC.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.content!,
                style: const TextStyle(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
