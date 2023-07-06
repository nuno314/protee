import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/family.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/shadow.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/join_family_requests_bloc.dart';

part 'join_family_requests.action.dart';

class JoinFamilyRequestsScreen extends StatefulWidget {
  final List<JoinFamilyRequest>? requests;
  const JoinFamilyRequestsScreen({
    Key? key,
    this.requests,
  }) : super(key: key);

  @override
  State<JoinFamilyRequestsScreen> createState() =>
      _JoinFamilyRequestsScreenState();
}

class _JoinFamilyRequestsScreenState
    extends StateBase<JoinFamilyRequestsScreen> {
  late final _refreshController =
      RefreshController(initialRefresh: widget.requests == null);

  @override
  JoinFamilyRequestsBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  List<JoinFamilyRequest> _requests = const [];

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
    _requests = widget.requests ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      headerColor: const Color(0xFF7C84F8),
      titleColor: themeColor.white,
      title: trans.joinRequest,
      child: BlocConsumer<JoinFamilyRequestsBloc, JoinFamilyRequestsState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildListing(state);
        },
      ),
    );
  }

  Widget _buildListing(JoinFamilyRequestsState state) {
    return SmartRefresherWrapper(
      enablePullDown: true,
      enablePullUp: state.canLoadMore,
      onRefresh: onRefresh,
      color: const Color(0xFF7C84F8),
      controller: _refreshController,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        itemBuilder: (context, index) {
          return _buildRequestUser(_requests.elementAt(index));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: _requests.length,
      ),
    );
  }

  Widget _buildRequestUser(JoinFamilyRequest request) {
    final _user = request.user;

    if (_user == null) {
      return const SizedBox();
    }

    return SwipeActionCell(
      backgroundColor: themeColor.transaprent,
      trailingActions: <SwipeAction>[
        SwipeAction(
          icon: SmartImage(
            image: Assets.svg.icTrash,
          ),
          backgroundRadius: 16,
          widthSpace: 48,
          onTap: (CompletionHandler handler) async {
            await declineRequest(handler, request);
          },
          color: const Color(0xffFDE8E6),
        ),
      ],
      key: GlobalKey(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: themeColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: boxShadowlight,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImageWrapper.avatar(
                url: _user.avatar!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _user.name ?? '--',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _user.dob?.toLocalDddmmyyyy(context) ?? '--',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: const Icon(Icons.check),
                color: themeColor.green,
                onPressed: () => _onTapApproveRequest(request),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
