import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/cache_network_image_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/home_page_bloc.dart';
import 'ui_parts/background.dart';

part 'home_page.action.dart';
part 'ui_parts/family_statistic.dart';
part 'ui_parts/header.dart';
part 'ui_parts/map_view.dart';
part 'ui_parts/features.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends StateBase<HomePageScreen> {
  late Timer _timer;
  int idx = 0;

  @override
  HomePageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        idx = (idx + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              HomePageBackground(screenSize: device),
              _buildBody(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(HomePageState state) {
    return Column(
      children: [
        _buildHeader(state),
        _buildFamilyStatistic(state),
        _buildHomePageFeatures(state),
      ],
    );
  }
}
