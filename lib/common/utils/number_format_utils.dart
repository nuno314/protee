import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class NumberFormatUtils {
  NumberFormatUtils._();

  static const _locale = 'vi_vn';

  static final NumberFormat vnFormat = NumberFormat.currency(
    locale: _locale,
    symbol: 'đ',
  );
  static final NumberFormat _numberFormat =
      NumberFormat.decimalPattern(_locale);

  static String? displayMoney(num? amount) {
    if (amount == null) {
      return null;
    }
    return amount.toCurrencyString(
      mantissaLength: 0,
      trailingSymbol: 'đ',
      useSymbolPadding: true,
      thousandSeparator: ThousandSeparator.Period,
    );
  }

  static String? decimalFormat(num? number) {
    return _numberFormat.format(number);
  }

  static double? parseDouble(String? string) {
    if (string == null || string.isEmpty == true) {
      return null;
    }
    return _numberFormat.parse(string).toDouble();
  }

  static String get currencySymbol {
    return vnFormat.currencySymbol;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = int.parse(newValue.text.replaceAll('.', ''));

    final newText = value.toAppCurrencyString(isWithSymbol: false);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
