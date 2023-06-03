import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

import '../../common/components/navigation/navigation_observer.dart';
import '../../common/utils.dart';
import '../common_widget/input_container/input_container.dart';
import '../extentions/extention.dart';
import 'shadow.dart';
import 'theme_color.dart';

@Injectable()
class ThemeDialog {
  AppLocalizations get trans => translate(navigatorKey.currentState!.context);

  String get cancel => trans.cancel;
  String get confirm => trans.confirm;
  String get ok => trans.ok;
  String get inform => trans.inform;

  Widget buildConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? leftBtn,
    String? rightBtn,
    TextStyle? styleRightBtn,
    TextStyle? styleLeftBtn,
    bool useRootNavigator = true,
    bool dismissWhenAction = true,
    void Function()? onConfirmed,
    void Function()? onCanceled,
  }) {
    final dismissFunc = () {
      if (dismissWhenAction) {
        Navigator.of(context, rootNavigator: useRootNavigator).pop();
      }
    };
    final theme = context.theme;

    final showAndroidDialog = () => AlertDialog(
          title: Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                dismissFunc.call();
                onCanceled?.call();
              },
              child: Text(
                leftBtn ?? cancel,
                style: styleLeftBtn ??
                    theme.textTheme.labelLarge?.copyWith(
                      color: themeColor.primaryColor,
                    ),
              ),
            ),
            TextButton(
              key: const ValueKey('ConfirmDialog_confirm_btn'),
              onPressed: () {
                dismissFunc.call();
                onConfirmed?.call();
              },
              child: Text(
                rightBtn ?? confirm,
                style: styleRightBtn ??
                    theme.textTheme.labelLarge?.copyWith(
                      color: themeColor.primaryColor,
                    ),
              ),
            ),
          ],
        );

    if (kIsWeb) {
      return showAndroidDialog();
    } else if (Platform.isAndroid) {
      return showAndroidDialog();
    } else {
      Widget _buildAction({
        Function()? onTap,
        required String title,
        TextStyle? style,
      }) {
        return RawMaterialButton(
          constraints: const BoxConstraints(minHeight: 45),
          padding: EdgeInsets.zero,
          onPressed: () {
            dismissFunc.call();
            onTap?.call();
          },
          child: Text(
            title,
            style: style ??
                theme.textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
          ),
        );
      }

      return CupertinoAlertDialog(
        title: Text(
          title,
          style: theme.textTheme.headlineSmall,
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                key: const ValueKey('ConfirmDialog_cancel_btn'),
                child: _buildAction(
                  onTap: onCanceled,
                  title: leftBtn ?? cancel,
                  style: styleLeftBtn,
                ),
              ),
              Container(width: 0.5, height: 44, color: Colors.grey),
              Expanded(
                key: const ValueKey('ConfirmDialog_confirm_btn'),
                child: _buildAction(
                  onTap: onConfirmed,
                  title: rightBtn ?? confirm,
                  style: styleRightBtn,
                ),
              ),
            ],
          )
        ],
      );
    }
  }

  Widget buildConfirmWithReasonDialog({
    required BuildContext context,
    required InputContainerController controller,
    required String title,
    String? hint,
    required String message,
    String? leftBtn,
    String? rightBtn,
    TextStyle? styleRightBtn,
    TextStyle? styleLeftBtn,
    bool useRootNavigator = true,
    bool dismissWhenAction = true,
    void Function(String)? onConfirmed,
    void Function(String)? onCanceled,
  }) {
    final _icReason = controller;
    final dismissFunc = () {
      if (dismissWhenAction) {
        Navigator.of(context, rootNavigator: useRootNavigator).pop(
          _icReason.text,
        );
      }
    };
    final theme = context.theme;

    final showAndroidDialog = () => AlertDialog(
          title: Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          content: InputContainer(
            controller: _icReason,
            maxLines: 6,
            title: message,
            hint: hint,
          ),
          actions: [
            TextButton(
              key: const ValueKey('ConfirmWithReasonDialog_cancel_btn'),
              onPressed: () {
                dismissFunc.call();
                onCanceled?.call(_icReason.text);
              },
              child: Text(
                leftBtn ?? cancel,
                style: styleLeftBtn ??
                    theme.textTheme.labelLarge?.copyWith(
                      color: themeColor.primaryColor,
                    ),
              ),
            ),
            TextButton(
              key: const ValueKey('ConfirmWithReasonDialog_confirm_btn'),
              onPressed: () {
                dismissFunc.call();
                onConfirmed?.call(_icReason.text);
              },
              child: Text(
                rightBtn ?? confirm,
                style: styleRightBtn ??
                    theme.textTheme.labelLarge?.copyWith(
                      color: themeColor.primaryColor,
                    ),
              ),
            ),
          ],
        );

    if (kIsWeb) {
      return showAndroidDialog();
    } else if (Platform.isAndroid) {
      return showAndroidDialog();
    } else {
      Widget _buildAction({
        Function()? onTap,
        required String title,
        TextStyle? style,
      }) {
        return RawMaterialButton(
          constraints: const BoxConstraints(minHeight: 45),
          padding: EdgeInsets.zero,
          onPressed: () {
            dismissFunc.call();
            onTap?.call();
          },
          child: Text(
            title,
            style: style ??
                theme.textTheme.labelLarge!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
          ),
        );
      }

      return CupertinoAlertDialog(
        title: Text(
          title,
          style: theme.textTheme.headlineSmall,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: InputContainer(
            controller: _icReason,
            maxLines: 4,
            title: message,
            hint: hint,
            fillColor: Colors.white,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                key: const ValueKey('ConfirmWithReasonDialog_cancel_btn'),
                child: _buildAction(
                  onTap: () => onCanceled?.call(_icReason.text),
                  title: leftBtn ?? cancel,
                  style: styleLeftBtn,
                ),
              ),
              Container(width: 0.5, height: 44, color: Colors.grey),
              Expanded(
                key: const ValueKey('ConfirmWithReasonDialog_confirm_btn'),
                child: _buildAction(
                  onTap: () => onConfirmed?.call(_icReason.text),
                  title: rightBtn ?? confirm,
                  style: styleRightBtn,
                ),
              ),
            ],
          )
        ],
      );
    }
  }

  Widget buildNoticeDialog({
    required BuildContext context,
    required String message,
    Widget? content,
    String? title,
    String? titleBtn,
    Function()? onClose,
    bool useRootNavigator = true,
    bool dismissWhenAction = true,
  }) {
    final dismissFunc = () {
      if (dismissWhenAction) {
        Navigator.of(context, rootNavigator: useRootNavigator).pop();
      }
    };
    final theme = context.theme;
    final showAndroidDialog = () => AlertDialog(
          title: Text(
            title ?? inform,
            style: theme.textTheme.headlineSmall,
          ),
          content: content ??
              Text(
                message,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
          actions: [
            TextButton(
              key: const ValueKey('NoticeDialog_close_btn'),
              onPressed: () {
                dismissFunc.call();
                onClose?.call();
              },
              child: Text(titleBtn ?? ok),
            )
          ],
        );

    if (kIsWeb) {
      return showAndroidDialog();
    } else if (Platform.isAndroid) {
      return showAndroidDialog();
    } else {
      return CupertinoAlertDialog(
        title: Text(title ?? inform),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            key: const ValueKey('NoticeDialog_close_btn'),
            onPressed: () {
              dismissFunc.call();
              onClose?.call();
            },
            child: Text(titleBtn ?? ok),
          ),
        ],
      );
    }
  }

  Widget buildActionDialog({
    required BuildContext context,
    Map<String, void Function()> actions = const <String, void Function()>{},
    String title = '',
    String? subTitle = '',
    bool useRootNavigator = true,
    bool dimissWhenSelect = true,
    String? titleBottomBtn,
  }) {
    final theme = context.theme;
    if (kIsWeb || Platform.isAndroid) {
      return AlertDialog(
        title: RichText(
          text: TextSpan(
            text: title,
            style: theme.textTheme.headlineSmall,
            children: [
              if (subTitle?.isNotEmpty == true)
                TextSpan(
                  text: '\n\n',
                  children: [
                    TextSpan(
                      text: subTitle,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        actions: [
          ...actions.entries
              .map<TextButton>(
                (e) => TextButton(
                  key: ValueKey('ActionDialog_${e.key}'),
                  onPressed: () {
                    if (dimissWhenSelect) {
                      Navigator.of(
                        context,
                        rootNavigator: useRootNavigator,
                      ).pop();
                    }
                    e.value.call();
                  },
                  child: Text(
                    e.key,
                    style: TextStyle(
                      color: themeColor.primaryColor,
                    ),
                  ),
                ),
              )
              .toList(),
          TextButton(
            key: const ValueKey('ActionDialog_close_btn'),
            onPressed: () {
              Navigator.of(context, rootNavigator: useRootNavigator).pop();
            },
            child: Text(
              titleBottomBtn ?? '',
              style: TextStyle(
                color: themeColor.primaryColor,
              ),
            ),
          ),
        ],
      );
    } else {
      return CupertinoActionSheet(
        actions: [
          ...actions.entries.map(
            (e) => CupertinoActionSheetAction(
              key: ValueKey('ActionDialog_${e.key}'),
              onPressed: () {
                if (dimissWhenSelect) {
                  if (dimissWhenSelect) {
                    Navigator.of(
                      context,
                      rootNavigator: useRootNavigator,
                    ).pop();
                  }
                  e.value.call();
                }
              },
              child: Text(
                e.key,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        message: subTitle?.isNotEmpty == true
            ? Text(
                subTitle!,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              )
            : null,
        cancelButton: CupertinoActionSheetAction(
          key: const ValueKey('ActionDialog_close_btn'),
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: useRootNavigator,
            ).pop();
          },
          child: Text(
            titleBottomBtn ?? '',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Widget buildModalBottomSheet({
    required BuildContext context,
    required Widget body,
    bool useRootNavigator = true,
    double? bottomPadding,
    String? title,
    void Function()? onClose,
  }) {
    final mediaData = MediaQuery.of(context);
    final theme = context.theme;

    final padding = mediaData.padding;
    final size = mediaData.size;
    final maxContentSize = size.height - padding.top - padding.bottom - 64;
    final _scrollController = ScrollController();
    return Padding(
      padding: mediaData.viewInsets,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              bottom: bottomPadding ?? mediaData.padding.bottom,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(8),
                topStart: Radius.circular(8),
              ),
              boxShadow: boxShadowMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const ValueKey('ModalBottomSheet_close_btn'),
                      onPressed: onClose ??
                          () => Navigator.of(
                                context,
                                rootNavigator: useRootNavigator,
                              ).pop(),
                      icon: Icon(
                        Icons.close,
                        size: 24,
                        color: themeColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  color: themeColor.primaryColor,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: maxContentSize),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: body,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
