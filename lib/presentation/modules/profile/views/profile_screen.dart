import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utils.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/custom_cupertino_date_picker.dart';
import '../../../common_widget/export.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';
import '../bloc/profile_bloc.dart';

part 'profile.action.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateBase<ProfileScreen> {
  final _nameController = InputContainerController();
  final _phoneNumberController = InputContainerController();
  final _dobController = InputContainerController();
  DateTime? _pickBirthday;

  @override
  ProfileBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: themeColor.primaryColor,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            margin: EdgeInsets.only(
                              top: device.height / 6,
                            ),
                            decoration: BoxDecoration(
                              color: themeColor.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: _buildUserForm(state),
                          ),
                          Positioned(
                            top: device.height / 6 - 50,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImageWrapper.avatar(
                                    url: state.user?.avatar ?? '',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.user?.name ?? '--',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: themeColor.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.user?.phoneNumber ?? '--',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  fillOverscroll: true,
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(
                      bottom: max(paddingBottom, 16),
                    ),
                    width: double.infinity,
                    child: ThemeButton.denied(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      context: context,
                      title: 'title',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserForm(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: device.height / 6 + 10),
        InputContainer(
          title: trans.fullName,
          required: true,
          hint: trans.pleaseEnterFullName,
        ),
        const SizedBox(height: 16),
        InputContainer(
          title: trans.phoneNumber,
          hint: trans.pleaseEnterPhoneNumber,
        ),
        const SizedBox(height: 16),
        _buildBirthdayInput(
          trans.dob.toUpperCase(),
          _dobController,
          hint: trans.pleaseSelectDOB,
          onPressed: _showBirthdayPicker,
          readOnly: true,
          suffixIcon: SvgPicture.asset(
            Assets.svg.icCalendar,
            color: themeColor.primaryColor,
          ),
          withClearButton: false,
        ),
        const SizedBox(height: 52),
      ],
    );
  }

  Widget _buildBirthdayInput(
    String title,
    InputContainerController controller, {
    String hint = '',
    bool readOnly = false,
    Widget? suffixIcon,
    bool withClearButton = true,
    Function()? onPressed,
  }) {
    return InputContainer(
      title: trans.dob.toUpperCase(),
      titleStyle: textTheme.bodyLarge?.copyWith(
        fontSize: 12,
        color: const Color(0xff8D8D94),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      controller: controller,
      hint: hint,
      readOnly: readOnly,
      suffixIcon: suffixIcon,
      suffixIconPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onPressed,
      fillColor: themeColor.white,
      showBorder: true,
      withClearButton: withClearButton,
    );
  }
}
