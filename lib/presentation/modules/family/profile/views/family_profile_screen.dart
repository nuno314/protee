import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/smart_refresher_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/family_profile_bloc.dart';
import 'widget/family_background.dart';

part 'family_profile.action.dart';

class FamilyProfileScreen extends StatefulWidget {
  const FamilyProfileScreen({Key? key}) : super(key: key);

  @override
  State<FamilyProfileScreen> createState() => _FamilyProfileScreenState();
}

class _FamilyProfileScreenState extends StateBase<FamilyProfileScreen> {
  final _controller = RefreshController(initialRefresh: true);

  @override
  FamilyProfileBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);

    return BlocConsumer<FamilyProfileBloc, FamilyProfileState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              FamilyProfileBackground(
                screenSize: device,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(state),
                  Expanded(
                    child: SmartRefresherWrapper(
                      color: const Color(0xFF7C84F8),
                      controller: _controller,
                      onRefresh: onRefresh,
                      child: _buildFamilyGeneralInfo(state),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(FamilyProfileState state) {
    final padding = MediaQuery.of(context).padding;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: padding.top + 16,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _onBack,
            icon: Icon(
              Icons.chevron_left_outlined,
              size: 24,
              color: themeColor.white,
            ),
          ),
          Expanded(
            child: Text(
              injector
                      .get<AppApiService>()
                      .localDataManager
                      .currentUser
                      ?.name ??
                  '--',
              style: TextStyle(
                fontSize: 20,
                color: themeColor.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: _onBack,
            icon: Icon(
              Icons.settings_outlined,
              size: 24,
              color: themeColor.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyGeneralInfo(FamilyProfileState state) {
    final members = [
      User(),
      User(),
    ];

    final children = [
      Text(
        state.family?.name ?? '--',
        style: TextStyle(
          fontSize: 30,
          color: themeColor.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      ...members.map(_buildMember).toList(),
      _buildAddMember(),
      const SizedBox(
        height: 30,
      )
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: children.elementAt(index),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: children.length,
    );
  }

  Widget _buildMember(User member) {
    return BoxColor(
      color: themeColor.white,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImageWrapper.avatar(
              url: member.avatar ?? '',
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                member.name ?? '--',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                member.dob ?? '--',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddMember() {
    return InkWell(
      onTap: _onTapAddMember,
      child: BoxColor(
        color: themeColor.white,
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: const Icon(Icons.add),
      ),
    );
  }

  
}
