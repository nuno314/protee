import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class CommonFunction {
  void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String prettyJsonStr(Map<dynamic, dynamic> json) {
    final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
    return encoder.convert(json);
  }

  String wrapStyleHtmlContent(String htmlContent, {bool isCenter = false}) {
    return '''<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <style>* {
        font-family: 'Nunito';
        line-height: 1.5;
        margin: 0;
        padding: 0;
      }
      h2 {
        font-size: 24px;
        margin-bottom: 12px;
      }
      h3 {
        font-size: 18px;
        margin-bottom: 12px;
      }
      h4 {
        font-size: 16px;
        margin-bottom: 10px;
      }
      hr {
        height: 1px;
        color: #123455;
        background-color: #123455;
        border: none;
      }
      p {
        font-size: 14px;
        margin-bottom: 10px;
      }
      a {
        text-decoration: underline;
      }
      img {
        display: block;
        margin: 0 auto;
        max-width: 100%;
        min-width: 50px;
      }
      .table {
        width: 100% !important;
        table {
          border: 1px double #B3B3B3;
          th, td {
            border: 1px double #D9D9D9;
          }
        }
      }
      figcaption {
        text-align: center;
      }
      div {
        padding-top: 8px;
        padding-right: 8px;
        padding-bottom: 8px;
        padding-left: 8px;
      }
      figure.image {
        display: inline-block;
        border: 1px solid gray;
        margin: 0 2px 0 1px;
        background: #f5f2f0;
      }
      figure.align-left {
        float: left;
      }
      figure.align-right {
        float: right;
      }
      figure.image img {
        margin: 8px 8px 0 8px;
      }
      figure.image figcaption {
        margin: 6px 8px 6px 8px;
        text-align: center;
      }
      img.align-left {
        float: left;
      }
      img.align-right {
        float: right;
      }
      .mce-toc {
        border: 1px solid gray;
      }
      .mce-toc h2 {
        margin: 4px;
      }
      .mce-toc li {
        list-style-type: none;
      }
      </style>
      <body>
        ${isCenter ? '<center>' : ''}
        <div>
          $htmlContent
        </div>
        ${isCenter ? '</center>' : ''}
      </body>
    </html>''';
  }

  Map<String, String> customStylesBuilder(dom.Element element) {
    final style = {
      'line-height': '1.5',
      'margin': '0',
      'padding': '0',
    };
    switch (element.localName) {
      case 'h2':
        return {
          'font-family': 'Nunito',
          'font-size': '24px',
          'margin-bottom': '12px',
          ...style
        };
      case 'h3':
        return {
          'font-family': 'Nunito',
          'font-size': '18px',
          'margin-bottom': '12px',
          ...style
        };
      case 'h4':
        return {
          'font-family': 'Nunito',
          'font-size': '16px',
          'margin-bottom': '10px',
          ...style
        };
      case 'p':
        return {
          'font-family': 'Nunito',
          'font-size': '14px',
          'margin-bottom': '10px',
          ...style
        };
      case 'a':
        return {
          'font-family': 'Nunito',
          'text-decoration': 'underline',
          ...style
        };
      case 'img':
        return {
          'display': 'block',
          'max-width': '100%',
          'min-width': '50px',
          ...style
        };
      case 'figcaption':
        return {'font-family': 'Nunito', 'text-align': 'center'};
      case 'style':
        return {
          'font-family': 'Nunito',
          'line-height': '1.5',
          'margin': '0',
          'padding': '0',
        };
      case '.table':
        return {'width': '100% !important', ...style};
      case 'table':
        return {'border': '1px double #B3B3B3', ...style};
      case 'th':
      case 'td':
        return {'border': '1px double #D9D9D9', ...style};
      case 'ol':
      case 'ul':
        return {'padding-left': '24px', 'font-size': '14px'};
      case '::marker':
        return {
          'unicode-bidi': 'isolate',
          'font-variant-numeric': 'tabular-nums',
          'text-transform': 'none',
          'text-indent': '0px !important',
          'text-align': 'start !important',
          'text-align-last': 'start !important',
          ...style
        };
      default:
        return {
          'font-family': 'Nunito',
          'line-height': '1.5',
          'margin': '0',
          'padding': '0',
        };
    }
  }

  int calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
    final month1 = currentDate.month;
    final month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  bool shouldUpdateApp(String currentVersion, String newVersion) {
    if (newVersion.isEmpty) {
      return false;
    }
    return _compareVersionNames(currentVersion, newVersion) < 0;
  }

  bool compare(String currentVersion, String newVersion) {
    if (newVersion.isEmpty) {
      return false;
    }
    return _compareVersionNames(currentVersion, newVersion) == 0;
  }

  @visibleForTesting
  int compareVersionNames(
    String oldVersionName,
    String newVersionName,
  ) =>
      _compareVersionNames(oldVersionName, newVersionName);

  int _compareVersionNames(
    String oldVersionName,
    String newVersionName,
  ) {
    var res = 0;

    final oldNumbers = oldVersionName.split('.');
    final newNumbers = newVersionName.split('.');

    // To avoid IndexOutOfBounds
    final maxIndex = min(oldNumbers.length, newNumbers.length);

    for (final i in List.generate(maxIndex, (index) => index)) {
      final oldVersionPart = int.tryParse(oldNumbers[i]);
      final newVersionPart = int.tryParse(newNumbers[i]);

      if (newVersionPart == null || oldVersionPart == null) {
        break;
      }

      if (oldVersionPart < newVersionPart) {
        res = -1;
        break;
      } else if (oldVersionPart > newVersionPart) {
        res = 1;
        break;
      }
    }

    // If versions are the same so far, but they have different length...
    if (res == 0 && oldNumbers.length != newNumbers.length) {
      res = oldNumbers.length > newNumbers.length ? 1 : -1;
    }
    return res;
  }

  Future<void> navigateToCustAppStore() async {
    var storeUrl = '';
    if (Platform.isIOS) {
      storeUrl = 'https://apps.apple.com/us/app/diva-queen/id6448968881';
    } else if (Platform.isAndroid) {
      storeUrl = 'https://play.google.com/store/apps/details?id=com.dva.queen';
    }

    if (await canLaunchUrl(Uri.parse(storeUrl))) {
      await launchUrl(Uri.parse(storeUrl));
    }
  }

  Future<void> navigateToStaffAppStore() async {
    var storeUrl = '';
    if (Platform.isIOS) {
      storeUrl = 'https://apps.apple.com/us/app/diva-partner/id6448969817';
    } else if (Platform.isAndroid) {
      storeUrl =
          'https://play.google.com/store/apps/details?id=com.dva.partner';
    }

    if (await canLaunchUrl(Uri.parse(storeUrl))) {
      await launchUrl(Uri.parse(storeUrl));
    }
  }

  String randomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }
}
