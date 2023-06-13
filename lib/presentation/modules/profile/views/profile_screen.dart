import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/user.dart';
import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/custom_cupertino_date_picker.dart';
import '../../../common_widget/export.dart';
import '../../../common_widget/footer_widget.dart';
import '../../../extentions/extention.dart';
import '../../../theme/shadow.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';
import '../bloc/profile_bloc.dart';

part 'profile.action.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen({this.user, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateBase<ProfileScreen> {
  final _nameController = InputContainerController();
  final _phoneNumberController = InputContainerController();
  final _dobController = InputContainerController();
  DateTime? _pickBirthday;
  final avatarValue = ValueNotifier<File?>(null);

  User? _user;

  @override
  ProfileBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameController.text = _user?.name;
    _dobController.text = _user?.dob?.toLocalddmmyyyy();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: _onBack,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                    decoration: BoxDecoration(
                      boxShadow: boxShadowlight,
                      color: themeColor.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SvgPicture.asset(
                      Assets.svg.icChevronLeft,
                      color: themeColor.black,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              16,
                            ),
                            margin: EdgeInsets.only(
                              top: device.height / 13,
                              left: 16,
                              right: 16,
                            ),
                            decoration: BoxDecoration(
                              color: themeColor.white,
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                            ),
                            child: _buildUserForm(state),
                          ),
                          Positioned(
                            top: device.height / 13 - 50,
                            child: InkWell(
                              onTap: _showImagePickerActionDialog,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(44),
                                    child: ValueListenableBuilder<File?>(
                                      valueListenable: avatarValue,
                                      builder: (context, avatarFile, _) {
                                        if (avatarFile != null) {
                                          return Image.file(
                                            avatarFile,
                                            width: 88,
                                            height: 88,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                        return CachedNetworkImageWrapper.avatar(
                                          url: widget.user?.avatar ?? '',
                                          width: 88,
                                          height: 88,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: themeColor.primaryColorLight,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: themeColor.cardBackground,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FooterWidget(
                  child: ThemeButton.primary(
                    context: context,
                    title: trans.update,
                    onPressed: _onTapUpdate,
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
          controller: _nameController,
          title: trans.fullName,
          required: true,
          hint: trans.pleaseEnterFullName,
        ),
        const SizedBox(height: 16),
        InputContainer(
          controller: _phoneNumberController,
          title: trans.phoneNumber,
          hint: trans.pleaseEnterPhoneNumber,
        ),
        const SizedBox(height: 16),
        _buildBirthdayInput(
          trans.dob,
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
      title: title,
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
