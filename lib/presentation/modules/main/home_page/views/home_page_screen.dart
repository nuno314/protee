import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../bloc/home_page_bloc.dart';

part 'home_page.action.dart';

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
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          child: Image.asset(Assets.image.logo),
        );
      },
    );
  }
}
