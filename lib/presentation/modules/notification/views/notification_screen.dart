import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/export.dart';
import '../../../common_widget/html_widget_wrapper.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../extentions/extention.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import '../bloc/notification_bloc.dart';

part 'notification.action.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends StateBase<NotificationScreen> {
  final _refreshController = RefreshController(initialRefresh: true);
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
          actions: [
            InkWell(
              onTap: _markAllNoti,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: SvgPicture.asset(
                  Assets.svg.icMarkNotiRead,
                  width: 24,
                  height: 24,
                  color: themeColor.white,
                ),
              ),
            )
          ],
          child: _buildListing(state),
        );
      },
    );
  }

  Widget _buildListing(NotificationState state) {
    final notifications = state.notifications;
    return SmartRefresherWrapper(
      controller: _refreshController,
      enablePullUp: state.canLoadMore,
      onRefresh: onRefresh,
      onLoading: loadMore,
      child: notifications.isEmpty
          ? EmptyData(
              icon: Assets.svg.icEmptyNotification,
              emptyMessage: trans.noNotification,
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) =>
                  _buildNotificationItem(notifications.elementAt(index)),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: notifications.length,
            ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return InkWell(
      onTap: () => _onTapNoti(notification),
      child: BoxColor(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        color: notification.isRead != true
            ? themeColor.white
            : themeColor.greyDC.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            SvgPicture.asset(
              notification.type?.icon ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HtmlWidgetWrapper(
                    htmlContent: notification.title ?? '',
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.createdAt?.toLocalHHnnddmmyyWithCommas() ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: themeColor.gray8C,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapNoti(NotificationModel noti) {
    if (noti.id.isNotNullOrEmpty && noti.isRead == false) {
      bloc.add(ReadNotificationEvent(noti.id!));
    }
    final type = noti.type;
    if (type == null) {
      return;
    }
    switch (type) {
      case NotificationType.addLocation:
        Navigator.pushNamed(context, RouteList.locationListing);
        break;
      case NotificationType.joinRequest:
        Navigator.pushNamed(context, RouteList.joinFamilyRequests);
        break;
      case NotificationType.leaveFamily:
        break;
      case NotificationType.upgradeToParent:
      case NotificationType.downgradeToChild:
      case NotificationType.approvedJoinFamily:
        Navigator.pushNamed(context, RouteList.familyProfile);
        break;
      case NotificationType.removedFromFamily:
        break;
    }
  }
}
