part of 'extention.dart';

Future<dynamic> showNoticeDialog({
  required BuildContext context,
  required String message,
  Widget? content,
  String? title,
  String? titleBtn,
  bool barrierDismissible = true,
  Function()? onClose,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      return injector<ThemeDialog>().buildNoticeDialog(
        context: context,
        title: title,
        message: message,
        content: content,
        dismissWhenAction: dismissWhenAction,
        useRootNavigator: useRootNavigator,
        onClose: onClose,
        titleBtn: titleBtn,
      );
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
  String? title,
}) {
  return showNoticeDialog(
    context: context,
    message: message,
    barrierDismissible: barrierDismissible,
    onClose: onClose,
    titleBtn: titleBtn,
    useRootNavigator: useRootNavigator,
    title: title,
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
      return injector<ThemeDialog>().buildConfirmDialog(
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

Future<dynamic> showNoticeConfirmWithReasonDialog({
  required BuildContext context,
  required String message,
  required String title,
  String? hint,
  bool barrierDismissible = true,
  String? leftBtn,
  String? rightBtn,
  void Function(String reason)? onConfirmed,
  void Function(String reason)? onCanceled,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
  TextStyle? styleRightBtn,
  TextStyle? styleLeftBtn,
}) {
  final _icReasonCtr = InputContainerController();
  return showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      // Using scaffold for resizeToAvoidBottomInset
      return GestureDetector(
        onTap: () {
          if (_icReasonCtr.value.focusNode.hasFocus) {
            CommonFunction().hideKeyBoard(context);
          } else if (barrierDismissible) {
            Navigator.of(context, rootNavigator: useRootNavigator).pop(
              _icReasonCtr.text,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: injector<ThemeDialog>().buildConfirmWithReasonDialog(
            context: context,
            controller: _icReasonCtr,
            title: title,
            hint: hint,
            message: message,
            onConfirmed: onConfirmed,
            onCanceled: onCanceled,
            dismissWhenAction: dismissWhenAction,
            useRootNavigator: useRootNavigator,
            leftBtn: leftBtn,
            rightBtn: rightBtn,
            styleLeftBtn: styleLeftBtn,
            styleRightBtn: styleRightBtn,
          ),
        ),
      );
    },
  ).then((value) {
    _icReasonCtr.dispose();
    return value;
  });
}

Future<dynamic> showModal(
  BuildContext context,
  Widget body, {
  bool useRootNavigator = true,
  double? bottomPadding,
  String? title,
  void Function()? onClose,
}) {
  return showModalBottomSheet<dynamic>(
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return injector<ThemeDialog>().buildModalBottomSheet(
        context: context,
        body: body,
        bottomPadding: bottomPadding,
        onClose: onClose,
        title: title,
        useRootNavigator: useRootNavigator,
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
        return injector<ThemeDialog>().buildActionDialog(
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
        return injector<ThemeDialog>().buildActionDialog(
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
