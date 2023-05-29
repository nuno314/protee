import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
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
                children: [
                  _buildHeader(state),
                  _buildFamilyGeneralInfo(state),
                  _buildFamilyCards(state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onBack() {
    Navigator.pop(context);
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
              'Nguyễn Thị Linh',
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
    final mockAvts = [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImageWrapper.avatar(
          url: '',
          width: 80,
          height: 80,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImageWrapper.avatar(
          url: '',
          width: 80,
          height: 80,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImageWrapper.avatar(
          url: '',
          width: 80,
          height: 80,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10000),
        child: CachedNetworkImageWrapper.avatar(
          url: '',
          width: 80,
          height: 80,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImageWrapper.avatar(
          url: '',
          width: 80,
          height: 80,
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gia đình',
                style: TextStyle(fontSize: 24, color: themeColor.white),
              ),
              const SizedBox(height: 4),
              Text(
                'Là Số Một',
                style: TextStyle(
                  fontSize: 30,
                  color: themeColor.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: mockAvts.elementAt(index),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: mockAvts.length,
          ),
        )
      ],
    );
  }

  Widget _buildFamilyCards(FamilyProfileState state) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xff012303),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const GoogleMap(
              compassEnabled: false,
              zoomControlsEnabled: false,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
