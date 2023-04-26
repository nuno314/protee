import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/box_color.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/account_bloc.dart';

part 'account.action.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends StateBase<AccountScreen> {
  @override
  AccountBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<AccountBloc, AccountState>(
      listener: _blocListener,
      builder: (context, state) {
        return Center(
          child: InkWell(
            onTap: _onTapLogOut,
            child: BoxColor(
              color: themeColor.primaryColor,
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(8),
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeColor.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapLogOut() {
    showNoticeDialog(
      context: context,
      message: 'mún đăng xuất hok',
      title: trans.inform,
    ).then((value) {
      doLogout().then((value) {
        hideLoading();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteList.signIn,
          (_) => false,
        );
      });
    });
  }
}
