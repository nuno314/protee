import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/message_detail_bloc.dart';

part 'message_detail.action.dart';

class MessageDetailArgs {
  final UserFamily? initial;
  final String? id;

  MessageDetailArgs({this.initial, this.id});
}

class MessageDetailScreen extends StatefulWidget {
  final MessageDetailArgs? args;

  const MessageDetailScreen({Key? key, this.args}) : super(key: key);

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends StateBase<MessageDetailScreen> {
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  MessageDetailBloc get bloc => BlocProvider.of(context);

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
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      title: trans.member,
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      bgColor: themeColor.white,
      child: BlocConsumer<MessageDetailBloc, MessageDetailState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  Widget _buildBody(MessageDetailState state) {
    return SmartRefresherWrapper(
      enablePullDown: true,
      onRefresh: onRefresh,
      controller: _refreshController,
      child: const SizedBox(height: 16),
    );
  }
}
