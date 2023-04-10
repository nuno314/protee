import 'dart:async';

class Debouncer<T> {
  final Duration duration;
  final void Function(T? value) onValue;

  Debouncer(this.duration, this.onValue);

  T? _value;
  Timer? _timer;

  T? get value => _value;
  var _isDebouncing = false;

  bool get debouncing => _isDebouncing;

  set value(T? val) {
    _isDebouncing = true;
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _isDebouncing = false;
      onValue(_value);
    });
  }
}
