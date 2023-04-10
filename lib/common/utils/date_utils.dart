// ignore_for_file: constant_identifier_names

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tag_format;

import '../client_info.dart';
import '../constants/locale/datetime/vi.dart';
import 'extensions.dart';

class DateUtils {
  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  static const HHnnddmmyyyy = [HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy];

  /// **[HH, ':', nn]**
  ///
  /// **10:59**
  static const timeFormat = [HH, ':', nn];

  /// **[D, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **Tue, 01/01/2000**
  static const Dddmmyyyy = [D, ', ', dd, '/', mm, '/', yyyy];

  /// **[yyyy, '/', mm, '/', dd]**
  ///
  /// **2000/01/01**
  static const yyyymmdd = [yyyy, '/', mm, '/', dd];

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  static const ddmmyyyy = [dd, '/', mm, '/', yyyy];

  /// **[yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **2000-01-01 10:59:59**
  static const yyyymmddHHnnss = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn,
    ':',
    ss
  ];

  /// **[HH, ':', nn, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59, 01/01/2000**
  static const HHnnddmmyyWithCommas = [
    HH,
    ':',
    nn,
    ', ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  /// **[D, '\n', dd]**
  ///
  /// **Tue**
  ///
  /// **01**
  static const DAbovedd = [D, '\n', dd];

  /// **[mm, ' ', yyyy]**
  ///
  /// **01 2000**
  static const mmSpaceyyyy = [mm, ' ', yyyy];

  /// **[yyyy, mm, dd, HH, nn, ss]**
  ///
  /// **20001225105959**
  static const yyyymmddHHnnssWithoutSeparate = [yyyy, mm, dd, HH, nn, ss];
}

extension DateUtilsExtention on DateTime {
  String customFormat(List<String> format, {BuildContext? context}) {
    return formatDate(
      toLocal(),
      format,
      locale: context?.appDateLocale ?? VIDateLocale().toAppDateLocale,
    );
  }

  /// **[mm, ' ', yyyy]**
  ///
  /// **01 2000**
  String toLocalmmyyyy() {
    return formatDate(
      toLocal(),
      DateUtils.mmSpaceyyyy,
    );
  }

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  String toLocalddmmyyyy() {
    return formatDate(
      toLocal(),
      DateUtils.ddmmyyyy,
    );
  }

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  String toddmmyyyy() {
    return formatDate(
      this,
      DateUtils.ddmmyyyy,
    );
  }

  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  String toLocalHHnnddmmyyyy() {
    return formatDate(
      toLocal(),
      DateUtils.HHnnddmmyyyy,
    );
  }

  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  String toUTCHHnnddmmyyyy() {
    return formatDate(
      toUtc(),
      DateUtils.HHnnddmmyyyy,
    );
  }

  /// **[yyyy, '/', mm, '/', dd]**
  ///
  /// **2000/01/01**
  String toUTCyyyymmdd() {
    return formatDate(
      toUtc(),
      DateUtils.yyyymmdd,
    );
  }

  /// **[yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **2000-01-01 10:59:59**
  String toUTCyyyymmddHHnnss() {
    return formatDate(
      toUtc(),
      DateUtils.yyyymmddHHnnss,
    );
  }

  /// **[HH, ':', nn, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59, 01/01/2000**
  String toLocalHHnnddmmyyWithCommas() {
    return formatDate(
      toLocal(),
      DateUtils.HHnnddmmyyWithCommas,
    );
  }

  /// **[yyyy, mm, dd, HH, nn, ss]**
  ///
  /// **20001225105959**
  String toLocalyyyymmddHHnnssWithoutSeparate() {
    return formatDate(
      toLocal(),
      DateUtils.yyyymmddHHnnssWithoutSeparate,
    );
  }

  String? timeago() {
    return tag_format.format(
      this,
      locale: ClientInfo.languageCode,
      allowFromNow: true,
    );
  }

  /// **[HH, ':', nn]**
  ///
  /// **10:59**
  String toTimeFormat() {
    return formatDate(
      toLocal(),
      DateUtils.timeFormat,
    );
  }

  /// **[D, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **Tue, 01/01/2000**
  String toLocalDddmmyyyy(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.Dddmmyyyy,
      locale: context.appDateLocale,
    );
  }

  /// **[D, '\n', dd]**
  ///
  /// **Tue**
  ///
  /// **01**
  String toLocalDAbovedd(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.DAbovedd,
      locale: context.appDateLocale,
    );
  }
}
