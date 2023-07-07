import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/join_family_bloc.dart';

part 'join_family.action.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({Key? key}) : super(key: key);

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends StateBase<JoinFamilyScreen> {
  final _errorController = StreamController<ErrorAnimationType>();
  final _codeController = TextEditingController();
  @override
  JoinFamilyBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;
  final focusNode = FocusNode();

  @override
  void onError(ErrorData error) {
    hideLoading();
    if (error.message?.toLowerCase().contains('invalid') == true) {
      showErrorDialog(trans.invalidInvitationCode);
    } else if (error.message?.toLowerCase().contains('current') == true) {
      showErrorDialog(trans.waitForApproval);
    } else if (error.message?.toLowerCase().contains('waiting') == true) {
      showErrorDialog(trans.waitingJoinFamily);
    } else if (error.message?.toLowerCase().contains('other') == true) {
      showErrorDialog(trans.joinedWarning);
    } else if (error.message?.toLowerCase().contains('joined') == true) {
      showErrorDialog(trans.waitingJoinFamily);
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return ScreenForm(
      title: trans.joinFamily.capitalizeFirstofEach(),
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
          Text(
            trans.enterInvitationCode,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),

          _pinCodeField(state),
          const SizedBox(height: 16),
          Text(
            trans.sendRequestNote,
            style: TextStyle(
              color: themeColor.gray8C,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          // ThemeButton.primary(
          //   context: context,
          //   title: trans.joinFamily,
          //   onPressed: _onTapJoinFamily,
          // ),
        ],
      ),
    );
  }

  Widget _pinCodeField(JoinFamilyState state) {
    return Container(
      width: 300,
      child: PinCodeTextField(
        key: const ValueKey('otp_input'),
        appContext: context,
        autoFocus: true,
        length: 6,
        focusNode: focusNode,
        animationType: AnimationType.fade,
        cursorColor: themeColor.primaryColor,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,
          borderWidth: 1,
          activeFillColor: themeColor.white,
          selectedFillColor: themeColor.lightGrey.withOpacity(0.2),
          selectedColor: themeColor.lightGrey.withOpacity(0.2),
          inactiveFillColor: themeColor.lightGrey.withOpacity(0.2),
          inactiveColor: themeColor.lightGrey.withOpacity(0.2),
          activeColor: themeColor.black,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        enablePinAutofill: false,
        errorAnimationController: _errorController,
        controller: _codeController,
        onCompleted: _onTapJoinFamily,
        onChanged: (value) {
          // bloc?.add(ClearVerificationErrorEvent());
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
