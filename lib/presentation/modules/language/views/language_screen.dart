import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/utils.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/export.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/language_bloc.dart';

part 'language.action.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends StateBase<LanguageScreen> {
  @override
  LanguageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      onBack: () {
        hideLoading();
        Navigator.pop(context);
      },
      title: trans.changeLanguage.capitalizeFirstofEach(),
      child: BlocConsumer<LanguageBloc, LanguageState>(
        listener: _blocListener,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                _buildLocalization(
                  icon: Assets.svg.icVietnam,
                  locale: const Locale('vi'),
                  languageName: trans.vietnamese,
                ),
                const Divider(),
                _buildLocalization(
                  icon: Assets.svg.icUsa,
                  locale: const Locale('en'),
                  languageName: trans.english,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLocalization({
    required Locale locale,
    required String icon,
    required String languageName,
  }) {
    return InkWell(
      onTap: () => _onTapLocale(locale),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              languageName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTapLocale(Locale locale) {
    showNoticeConfirmDialog(
      context: context,
      message: trans.confirmChangeLanguage,
      title: trans.inform,
      onConfirmed: () {
        showLoading();
        bloc.add(UpdateLanguageEvent(locale));
      },
    );
  }
}
