import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/utils.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/family_settings_bloc.dart';

part 'family_settings.action.dart';

class FamilySettingsScreen extends StatefulWidget {
  const FamilySettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FamilySettingsScreen> createState() => _FamilySettingsScreenState();
}

class _FamilySettingsScreenState extends StateBase<FamilySettingsScreen> {
  @override
  FamilySettingsBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: _onTapLeaveFamily,
                  child: BoxColor(
                    color: themeColor.white,
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.icLeave,
                          width: 24,
                          height: 24,
                          color: themeColor.red,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            trans.leaveFamily,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: themeColor.gray8C,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
