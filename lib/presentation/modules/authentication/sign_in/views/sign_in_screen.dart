import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../common/utils.dart';
import '../../../../../di/di.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/box_color.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/sign_in_bloc.dart';
import 'widget/sign_in_background.dart';

part 'sign_in.action.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends StateBase<SignInScreen> {
  @override
  SignInBloc get bloc => BlocProvider.of(context);

  final _googleSignIn = injector.get<GoogleSignIn>();

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    final screenSize = device;

    return BlocConsumer<SignInBloc, SignInState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SigninBg(screenSize: screenSize),
              buildBody(state),
            ],
          ),
        );
      },
    );
  }

  Widget buildBody(SignInState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                Assets.image.signInWelcome,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            trans.childSafetyProtectionSystem,
            style: TextStyle(
              fontSize: 14,
              color: themeColor.gray8C,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildLoginButton(
            icon: Assets.svg.icApple,
            title: trans.appleLogin,
            color: themeColor.black,
          ),
          _buildLoginButton(
            icon: Assets.svg.icGoogle,
            title: trans.googleLogin,
            color: themeColor.red,
            onTap: onLoginWithGoogle,
          ),
          _buildLoginButton(
            icon: Assets.svg.icFacebook,
            title: trans.facebookLogin,
            color: themeColor.color3b5998,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required String icon,
    required String title,
    required Color color,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: BoxColor(
        color: color,
        borderRadius: BorderRadius.circular(8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: themeColor.white,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: themeColor.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
