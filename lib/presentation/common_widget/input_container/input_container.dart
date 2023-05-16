import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/utils.dart';
import '../../theme/app_text_theme.dart';

part 'input_container.controller.dart';

class InputContainer extends StatefulWidget {
  final InputContainerController? controller;
  final String? hint;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function()? onTap;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final Color? fillColor;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final TextAlign textAlign;
  final int? maxLength;
  final bool showBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry prefixIconPadding;
  final EdgeInsetsGeometry suffixIconPadding;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final double prefixIconSize;
  final double suffixIconSize;
  final BorderRadius borderRadius;
  final bool justShowPrefixIconWhenEmpty;
  final bool withClearButton;
  final void Function()? onClear;

  const InputContainer({
    Key? key,
    this.controller,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onTextChanged,
    this.maxLines = 1,
    this.inputFormatters,
    this.onSubmitted,
    this.onClear,
    this.enable = true,
    this.title,
    this.titleStyle,
    this.required = false,
    this.fillColor,
    this.prefixIcon,
    this.hintStyle,
    this.textStyle,
    this.borderSide,
    this.focusedBorderSide,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.showBorder = true,
    this.contentPadding,
    this.suffixIconPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.prefixIconPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.onEditingComplete,
    this.textInputAction,
    this.prefixIconSize = 16.0,
    this.suffixIconSize = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6.0)),
    this.justShowPrefixIconWhenEmpty = false,
    this.withClearButton = true,
  }) : super(key: key);

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  bool showPrefixIcon = true;

  InputContainerController? _controller;

  @override
  void initState() {
    _setupController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputContainer oldWidget) {
    _setupController();
    super.didUpdateWidget(oldWidget);
  }

  void _setupController() {
    _controller =
        widget.controller ?? _controller ?? InputContainerController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
      _controller = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = context.theme;
    if (widget.justShowPrefixIconWhenEmpty) {
      showPrefixIcon = _controller!.text.isEmpty;
    }
    return ValueListenableBuilder<InputContainerProperties>(
      valueListenable: _controller!,
      builder: (ctx, value, w) {
        Widget body;
        final textField = TextField(
          textAlign: widget.textAlign,
          focusNode: value.focusNode,
          readOnly: widget.readOnly || !widget.enable,
          controller: value.tdController,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            filled: !widget.enable || widget.fillColor != null,
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? themeData.textTheme.inputHint,
            errorText: value.validation,
            errorStyle: themeData.textTheme.inputError?.copyWith(
              fontSize: value.validation?.isNotEmpty == true ? null : 1,
            ),
            errorMaxLines: 2,
            suffixIcon: _getSuffixIcon(),
            suffixIconConstraints: BoxConstraints(
              minHeight: widget.suffixIconSize,
              minWidth: widget.suffixIconSize,
            ),
            prefixIcon: _getPrefixIcon(),
            prefixIconConstraints: BoxConstraints(
              minHeight: widget.prefixIconSize,
              minWidth: widget.prefixIconSize,
            ),
            fillColor: widget.enable ? widget.fillColor : null,
            counterStyle: themeData.textTheme.titleMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          style: widget.textStyle ??
              (widget.enable
                  ? themeData.textTheme.textInput
                  : themeData.textTheme.inputHint),
          obscureText:
              widget.isPassword && widget.controller?.isShowPass != true,
          onChanged: (text) {
            _showPrefixFilterFn(text);

            if (value.validation != null) {
              widget.controller?.resetValidation();
            }
            widget.onTextChanged?.call(text);
          },
          onEditingComplete: widget.onEditingComplete,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
        );
        if (widget.title?.isNotEmpty == true) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: widget.title,
                  style: widget.titleStyle ?? themeData.textTheme.inputTitle,
                  children: [
                    if (widget.required == true)
                      TextSpan(
                        text: ' *',
                        style: themeData.textTheme.inputRequired,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              textField,
            ],
          );
        } else {
          body = textField;
        }
        final inputDecorationTheme = themeData.inputDecorationTheme;
        return Theme(
          data: themeData.copyWith(
            primaryColor: themeData.colorScheme.secondary,
            primaryColorDark: themeData.colorScheme.secondary,
            inputDecorationTheme: InputDecorationTheme(
              border: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.border.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              enabledBorder: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.enabledBorder.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              focusedBorder: !widget.showBorder
                  ? InputBorder.none
                  : inputDecorationTheme.focusedBorder.let((it) {
                      if (it is OutlineInputBorder) {
                        return it.copyWith(
                          borderSide: widget.borderSide,
                          borderRadius: widget.borderRadius,
                        );
                      }
                      return it?.copyWith(
                        borderSide: widget.borderSide,
                      );
                    }),
              contentPadding: widget.contentPadding ??
                  themeData.inputDecorationTheme.contentPadding,
            ),
          ),
          child: body,
        );
      },
    );
  }

  Widget? _getSuffixIcon() {
    final padding = widget.suffixIconPadding;
    if (widget.isPassword) {
      final icon = _getPasswordIcon();
      return InkWell(
        onTap: widget.controller!.showOrHidePass,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      );
    }
    if (widget.withClearButton && widget.maxLines == 1) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller!.value.tdController,
        builder: (context, value, child) {
          if (value.text.isEmpty && widget.suffixIcon != null) {
            return Padding(
              padding: padding,
              child: widget.suffixIcon,
            );
          }
          if (!widget.enable || widget.readOnly) {
            return const SizedBox();
          }
          if (value.text.isNotEmpty != true) {
            if (widget.suffixIcon != null) {
              return Padding(
                padding: padding,
                child: widget.suffixIcon,
              );
            }
            return const SizedBox();
          }
          return InkWell(
            onTap: () {
              _controller!.clear();
              _showPrefixFilterFn(_controller!.text);
              widget.onTextChanged?.call(_controller!.text);
              widget.onClear?.call();
            },
            child: Padding(
              padding: padding,
              child: Icon(
                Icons.clear,
                size: widget.suffixIconSize,
              ),
            ),
          );
        },
      );
    }
    if (widget.suffixIcon != null) {
      return Padding(
        padding: padding,
        child: widget.suffixIcon,
      );
    }
    return null;
  }

  Widget _getPasswordIcon() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(
        widget.controller?.isShowPass == true
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        size: widget.suffixIconSize,
        color: Colors.grey,
      ),
    );
  }

  Widget? _getPrefixIcon() {
    final padding = widget.prefixIconPadding;
    if (!showPrefixIcon || widget.prefixIcon == null) {
      return null;
    }
    return Padding(
      padding: padding,
      child: widget.prefixIcon,
    );
  }

  void _showPrefixFilterFn(String text) {
    final isEmpty = text.isEmpty;
    if (widget.justShowPrefixIconWhenEmpty &&
        showPrefixIcon != isEmpty &&
        mounted) {
      setState(() {
        showPrefixIcon = isEmpty;
      });
    }
  }
}
