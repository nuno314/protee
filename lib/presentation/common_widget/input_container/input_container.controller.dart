part of 'input_container.dart';

class InputContainerProperties {
  TextEditingController tdController;
  String? validation;
  bool isShowPassword;
  FocusNode focusNode;

  InputContainerProperties({
    TextEditingController? tdController,
    this.validation,
    this.isShowPassword = false,
    FocusNode? focusNode,
  })  : tdController = tdController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode();

  void withValue({
    TextEditingController? tdController,
    FocusNode? focusNode,
  }) {
    this.tdController = tdController ?? this.tdController;
    this.focusNode = focusNode ?? this.focusNode;
  }
}

class InputContainerController extends ValueNotifier<InputContainerProperties> {
  InputContainerController({InputContainerProperties? value})
      : super(value ?? InputContainerProperties());

  String get text => value.tdController.text;

  set text(String? v) {
    value.tdController.let((ctrl) {
      ctrl.value = ctrl.value.copyWith(
        text: v,
        selection: TextSelection.collapsed(offset: v?.length ?? 0),
      );
    });
    resetValidation();
  }

  void resetValidation() {
    value.validation = null;
    notifyListeners();
  }

  void setError(String message) {
    value.focusNode.requestFocus();
    value.validation = message;
    notifyListeners();
  }

  void clearError() {
    value.validation = null;
    notifyListeners();
  }

  void requestFocus() {
    value.focusNode.requestFocus();
  }

  void unfocus() {
    value.focusNode.unfocus();
  }

  void reset() {
    value = InputContainerProperties(
      tdController: value.tdController,
      focusNode: value.focusNode,
    );
    notifyListeners();
  }

  bool get isShowPass => value.isShowPassword;

  void showOrHidePass() {
    value.isShowPassword = !value.isShowPassword;
    notifyListeners();
  }

  set selection(TextSelection selection) {
    value.tdController.selection = selection;
  }

  void clear() {
    value.tdController.clear();
    resetValidation();
  }
}
