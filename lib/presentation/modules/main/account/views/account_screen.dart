import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../common/utils.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
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
        return ScreenForm(
          title: 'Tài khoản',
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          showBackButton: false,
          child: Column(
            children: [
              _buildUserInfo(state),
              const SizedBox(height: 15),
              _buildMenuItems(state),
            ],
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

  Widget _buildUserInfo(AccountState state) {
    return Column(
      children: [
        ClipRRect(
          child: CachedNetworkImageWrapper.avatar(
            url: '',
            width: 84,
            height: 84,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Nguyễn Thị Linh',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '0361717651',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMenuItems(AccountState state) {
    return Column(
      children: [
        _settingItem(
          iconPath: Assets.svg.icPerson,
          title: 'Tài khoản',
          itemBorder: ItemBorder.top,
          divider: ItemDivider.line,
        ),
        _settingItem(
          iconPath: Assets.svg.icSettings,
          title: 'Cài đặt',
          divider: ItemDivider.line,
        ),
        _settingItem(
          iconPath: Assets.svg.icLogout,
          title: 'Đăng xuất',
          itemBorder: ItemBorder.bottom,
          callback: _onTapLogOut,
        ),
      ],
    );
  }

  Widget _settingItem({
    required String iconPath,
    required String title,
    final Widget? description,
    final ItemDivider? divider = ItemDivider.none,
    final ItemBorder itemBorder = ItemBorder.none,
    final void Function()? callback,
  }) {
    return MenuItemWidget(
      description: description,
      onTap: () {
        callback?.call();
      },
      divider: divider,
      itemBorder: itemBorder,
      title: title,
      tailIcon: Icon(
        Icons.arrow_forward_ios_rounded,
        color: themeColor.gray8C,
        size: 16,
      ),
      icon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: themeColor.primaryColor,
      ),
    );
  }
}
