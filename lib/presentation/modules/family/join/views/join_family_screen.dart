import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/join_family_bloc.dart';

part 'join_family.action.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({Key? key}) : super(key: key);

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends StateBase<JoinFamilyScreen> {
  final _codeController = InputContainerController();
  @override
  JoinFamilyBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void onError(ErrorData error) {
    hideLoading();
    if (error.message?.toLowerCase().contains('invalid') == true) {
      showErrorDialog(trans.invalidInvitationCode);
    } else if (error.message?.toLowerCase().contains('current') == true) {
      showErrorDialog(trans.waitingJoinFamily);
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      title: 'Gia nhập gia đình',
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      child: BlocConsumer<JoinFamilyBloc, JoinFamilyState>(
        listener: _blocListener,
        builder: (context, state) {
          return _buildListing(state);
        },
      ),
    );
  }

  Widget _buildListing(JoinFamilyState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Enter invitation code:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          InputContainer(
            controller: _codeController,
            textStyle: textTheme.bodyLarge?.copyWith(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          ThemeButton.primary(
            context: context,
            title: trans.joinFamily,
            onPressed: _onTapJoinFamily,
          ),
        ],
      ),
    );
  }
}
