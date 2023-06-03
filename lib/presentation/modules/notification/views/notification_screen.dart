import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/utils.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/export.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/notification_bloc.dart';

part 'notification.action.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends StateBase<NotificationScreen> {
  @override
  NotificationBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          title: trans.notification,
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          showBackButton: false,
          // child: Column(children: [

          // ]),c
          child: EmptyData(
            icon: Assets.svg.icEmptyNotification,
            emptyMessage: trans.noNotification,
          ),
        );
      },
    );
  }
}
