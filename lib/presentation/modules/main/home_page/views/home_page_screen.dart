import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/box_color.dart';
import '../../../../common_widget/cache_network_image_wrapper.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/home_page_bloc.dart';

part 'home_page.action.dart';
part 'ui_parts/header.dart';
part 'ui_parts/family_statistic.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends StateBase<HomePageScreen> {
  @override
  HomePageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return Scaffold(
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  Widget _buildBody(HomePageState state) {
    return Column(
      children: [
        _buildFamilyStatistic(state),
      ],
    );
  }
}
