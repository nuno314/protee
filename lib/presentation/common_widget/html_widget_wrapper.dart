import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fwfh_chewie/fwfh_chewie.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/utils/common_function.dart';

class HtmlWidgetWrapper extends StatelessWidget {
  final String htmlContent;
  final TextStyle? textStyle;
  final FutureOr<bool> Function(String)? onTapUrl;
  final bool wrapStyle;
  final bool center;

  const HtmlWidgetWrapper({
    super.key,
    required this.htmlContent,
    this.textStyle,
    this.onTapUrl,
    this.wrapStyle = true,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      wrapStyle
          ? CommonFunction().wrapStyleHtmlContent(
              htmlContent,
              isCenter: center,
            )
          : htmlContent,
      customStylesBuilder: CommonFunction().customStylesBuilder,
      factoryBuilder: CustomHTMLWidgetFactory.new,
      onTapUrl: (p0) {
        if (onTapUrl != null) {
          return onTapUrl!.call(p0);
        }
        launchUrlString(p0);
        return true;
      },
      textStyle: textStyle,
    );
  }
}

class CustomHTMLWidgetFactory extends WidgetFactory with ChewieFactory {
  @override
  bool get webView => true;
}
