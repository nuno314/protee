import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../constants/locale/app_locale.dart';
import '../constants/locale/date_locale.dart';
import '../constants/locale/datetime/en.dart';
import '../constants/locale/datetime/vi.dart';
import '../utils.dart';

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndex(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}

extension NullableStringIsNotNullOrEmptyExtension on String? {
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension StringExt on String {
  String displayNationalNumber() {
    return PhoneNumberUtils.parse(this)?.nationalNumber ?? '';
  }

  bool validVNPhoneNumber() {
    return PhoneNumberUtils.parse(this) != null;
  }

  bool isValidPhoneNumber() {
    if (isNullOrEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get isValidPassword {
    final length = this.length;
    final hasLetter = contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = contains(RegExp(r'[0-9]'));
    final isValid = (length >= 8) && hasLetter && hasNumber;
    return isValid;
  }

  bool get isValidStaffPassword {
    final length = this.length;
    final hasLowerCase = contains(RegExp(r'[a-z]'));
    final hasUpperCase = contains(RegExp(r'[A-Z]'));
    final hasSpecialChar = contains(RegExp(r'[.,*?!@#\$&*~]'));
    final isValid =
        (length >= 6) && hasLowerCase && hasUpperCase && hasSpecialChar;
    return isValid;
  }

  bool get isLocalUrl {
    return startsWith('/') ||
        startsWith('file://') ||
        (length > 1 && substring(1).startsWith(':\\'));
  }

  bool get isUrl => Uri.parse(this).isAbsolute;

  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String capitalizeFirstofEach() {
    return split(' ').map((str) => str.capitalizeFirst()).join(' ');
  }

  Duration parseDuration() {
    var hours = 0;
    var minutes = 0;
    var micros = 0;
    final parts = split(':');
    try {
      if (parts.isNotEmpty) {
        hours = int.parse(parts.first);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[1]);
      }
      if (parts.length > 2) {
        micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      }
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    } catch (_) {
      return Duration.zero;
    }
  }
}

extension CoreListExtension<E> on List<E>? {
  E? get firstOrNull {
    if (this?.isNotEmpty == true) {
      return this!.first;
    }
    return null;
  }
}

extension ListExtension<E> on List<E> {
  void addAllUnique(Iterable<E> iterable) {
    for (final element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }
}

extension DoubleExt on double {
  String toStringAsMaxFixed(int fractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = fractionDigits;
    return formatter.format(this);
  }
}

extension DistanceExt on double? {
  String get metterToKMDisplay {
    if (this == null) {
      return '--';
    }
    return (this! / 1000).toStringAsFixed(1);
  }
}

extension DateTimeConverter on int? {
  String toFullDateTime() {
    if (this == null) {
      return '';
    }
    final dt = DateTime.fromMillisecondsSinceEpoch(this!);
    return dt.toLocalHHnnddmmyyyy();
  }
}

extension CurrencyExt on num? {
  String toAppCurrencyString({bool isWithSymbol = true, String? locale}) {
    return NumberFormat.currency(
      locale: locale ?? AppLocale.defaultLocale.languageCode,
      symbol: isWithSymbol ? 'đ' : '',
      customPattern: '#,###${isWithSymbol ? '\u00a4' : ''}',
    ).format(this ?? 0);
  }

  String displayMoney() {
    return NumberFormatUtils.displayMoney(this) ?? '--';
  }
}

extension PhoneNumberExt on String? {
  String displayPhoneNumber() {
    if (isNullOrEmpty) {
      return '';
    }
    return PhoneNumberUtils.parse(this!)?.national ?? '';
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeDate(DateTime other) {
    return !isSameDay(other) && isBefore(other);
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    bool? isUtc,
  }) {
    return ((isUtc ?? this.isUtc) ? DateTime.utc : DateTime.new)(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
    );
  }

  DateTime get startDate {
    return DateTime(year, month, day);
  }

  DateTime get middle {
    return DateTime(year, month, day, 12);
  }

  DateTime get endDate {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get startThisWeek {
    return subtract(Duration(days: weekday - 1)).startDate;
  }

  DateTime get startThisMonth {
    return DateTime(year, month, 1);
  }

  DateTime get endThisMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime get startPrevWeek {
    return subtract(Duration(days: weekday + 6)).startDate;
  }

  DateTime get endPrevWeek {
    return startPrevWeek.add(const Duration(days: 6)).endDate;
  }

  DateTime get prevMonth {
    return copyWith(month: month - 1);
  }

  DateTime get startPrevMonth {
    return prevMonth.copyWith(day: 1).startDate;
  }

  DateTime get endPrevMonth {
    return startPrevMonth.let(
      (d) => d
          .copyWith(month: d.month + 1)
          .subtract(const Duration(days: 1))
          .endDate,
    );
  }
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T it) op) => op(this);
}

extension WeightExt on int {
  String formatNumber({String prefix = ''}) {
    const pattern = r'(\d{1,3})(?=(\d{3})+(?!\d))';
    final regExp = RegExp(pattern);
    final mathFunc = (Match match) => '${match[1]},';
    return '${toString().replaceAllMapped(regExp, mathFunc)}$prefix';
  }
}

extension ContextExt on BuildContext {
  AppDateLocale get appDateLocale {
    return Localizations.localeOf(this).languageCode ==
            AppLocale.en.languageCode
        ? ENDateLocale().toAppDateLocale
        : VIDateLocale().toAppDateLocale;
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
}

extension DurationExt on Duration {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String get hhmm {
    final twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    return '${twoDigits(inHours)}:$twoDigitMinutes';
  }

  String get hhmmss {
    return toString().split('.').first.padLeft(8, '0');
  }
}

extension FileSize on int? {
  double get bytesToGB {
    return (this ?? 0) / 1073741824;
  }

  double get bytesToMb {
    return (this ?? 0) / 1048576;
  }

  double get bytesToKb {
    return (this ?? 0) / 1024;
  }
}

class RiveAssets {
  final String artboard;
  final String stateMachineName;
  final String src;

  SMIBool? input;

  RiveAssets({
    this.src = '/assets/image/icons.riv',
    required this.artboard,
    this.stateMachineName = 'State Machine 1',
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

extension LatLngUtils on LatLng? {
  double? distanceFrom(LatLng? other) {
    if (this == null || other == null) {
      return null;
    }

    return Geolocator.distanceBetween(
      this!.latitude,
      this!.longitude,
      other.latitude,
      other.longitude,
    );
  }

  String get encode {
    if (this == null) {
      return '';
    }
    return Uri.encodeComponent('${this!.latitude},${this!.longitude}');
  }

  String get comma {
    if (this == null) {
      return '';
    }
    return '${this!.latitude},${this!.longitude}';
  }
}
