part of 'extention.dart';

Future<dynamic> showNoticeDialog({
  required BuildContext context,
  required String message,
  String? title,
  String? titleBtn,
  bool barrierDismissible = true,
  Function()? onClose,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
}) {
  final dismissFunc = () {
    if (dismissWhenAction) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  };
  final trans = translate(context);
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);

      final showAndroidDialog = () => AlertDialog(
            title: Text(
              title ?? trans.inform,
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
                  onClose?.call();
                },
                child: Text(titleBtn ?? trans.ok),
              )
            ],
          );

      if (kIsWeb) {
        return showAndroidDialog();
      } else if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        return CupertinoAlertDialog(
          title: Text(title ?? trans.inform),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                dismissFunc.call();
                onClose?.call();
              },
              child: Text(titleBtn ?? trans.ok),
            ),
          ],
        );
      }
    },
  );
}

Future<dynamic> showNoticeErrorDialog({
  required BuildContext context,
  required String message,
  bool barrierDismissible = false,
  void Function()? onClose,
  bool useRootNavigator = true,
  String? titleBtn,
}) {
  final trans = translate(context);
  return showNoticeDialog(
    context: context,
    message: message,
    barrierDismissible: barrierDismissible,
    onClose: onClose,
    titleBtn: titleBtn ?? trans.ok,
    useRootNavigator: useRootNavigator,
    title: trans.error,
  );
}

Future<dynamic> showNoticeWarningDialog({
  required BuildContext context,
  required String message,
  bool barrierDismissible = false,
  void Function()? onClose,
  bool useRootNavigator = true,
}) {
  final trans = translate(context);
  return showNoticeDialog(
    context: context,
    message: message,
    barrierDismissible: barrierDismissible,
    onClose: onClose,
    titleBtn: trans.ok,
    useRootNavigator: useRootNavigator,
    title: trans.warning,
  );
}

Future<dynamic> showNoticeConfirmDialog({
 required BuildContext context,
  required String message,
  required String title,
  bool barrierDismissible = true,
  String? leftBtn,
  String? rightBtn,
  void Function()? onConfirmed,
  void Function()? onCanceled,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
  TextStyle? styleRightBtn,
  TextStyle? styleLeftBtn,
}) {
  
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      return injector.get<ThemeDialog>().buildConfirmDialog(
            context: context,
            title: title,
            message: message,
            onConfirmed: onConfirmed,
            onCanceled: onCanceled,
            dismissWhenAction: dismissWhenAction,
            useRootNavigator: useRootNavigator,
            leftBtn: leftBtn,
            rightBtn: rightBtn,
            styleLeftBtn: styleLeftBtn,
            styleRightBtn: styleRightBtn,
          );
    },
  );
}

Future<void> showModal(
  BuildContext context,
  Widget content, {
  bool useRootNavigator = true,
  double? bottomPadding,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                bottom: bottomPadding ?? MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(8),
                  topStart: Radius.circular(8),
                ),
                boxShadow: boxShadowDark,
              ),
              child: content,
            )
          ],
        ),
      );
    },
  );
}

Future<dynamic> showActionDialog(
  BuildContext context, {
  Map<String, void Function()> actions = const <String, void Function()>{},
  String title = '',
  String? subTitle = '',
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  bool dimissWhenSelect = true,
  String? titleBottomBtn,
}) {
  if (kIsWeb || Platform.isAndroid) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return injector.get<ThemeDialog>().buildActionDialog(
              context: context,
              title: title,
              useRootNavigator: useRootNavigator,
              actions: actions,
              dimissWhenSelect: dimissWhenSelect,
              subTitle: subTitle,
              titleBottomBtn: titleBottomBtn,
            );
      },
    );
  } else {
    return showModalBottomSheet<dynamic>(
      context: context,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return injector.get<ThemeDialog>().buildActionDialog(
              context: context,
              title: title,
              useRootNavigator: useRootNavigator,
              actions: actions,
              dimissWhenSelect: dimissWhenSelect,
              subTitle: subTitle,
              titleBottomBtn: titleBottomBtn,
            );
      },
    );
  }
}
