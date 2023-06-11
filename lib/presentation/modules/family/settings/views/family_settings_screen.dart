import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/family.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/family_settings_bloc.dart';

part 'family_settings.action.dart';

class FamilySettingsScreen extends StatefulWidget {
  final Family? family;
  const FamilySettingsScreen({
    Key? key,
    this.family,
  }) : super(key: key);

  @override
  State<FamilySettingsScreen> createState() => _FamilySettingsScreenState();
}

class _FamilySettingsScreenState extends StateBase<FamilySettingsScreen> {
  @override
  FamilySettingsBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  Family? _family;
  @override
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _family = widget.family;
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<FamilySettingsBloc, FamilySettingsState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          headerColor: const Color(0xFF7C84F8),
          titleColor: themeColor.white,
          title: trans.familySettings,
        );
      },
    );
  }
}
