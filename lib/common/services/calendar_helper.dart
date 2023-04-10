import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../presentation/theme/theme_color.dart';
import '../utils/log_utils.dart';

class CalendarHelper {
  static Future<bool> addCalendarEvent({
    required String title,
    String description = '',
    String location = '',
    required DateTime startDate,
    required DateTime endDate,
    String? calendarId,
    Color? calendarColor,
  }) async {
    final _deviceCalendarPlugin = DeviceCalendarPlugin();
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && permissionsGranted.data != true) {
      permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || permissionsGranted.data != true) {
        return false;
      }
    }
    final calendars = (await _deviceCalendarPlugin.retrieveCalendars()).data
        as List<Calendar>;
    final calendar = Calendar();
    if (calendarId == null || !calendars.any((e) => e.id == calendarId)) {
      calendar.id = (await _deviceCalendarPlugin.createCalendar(
        title,
        calendarColor: calendarColor ?? themeColor.primaryColor,
      ))
          .data;
    }
    if (timeZoneDatabase.locations.isEmpty) {
      tz.initializeTimeZones();
    }
    final _timezone = await FlutterNativeTimezone.getLocalTimezone();
    final currentLocation = timeZoneDatabase.locations[_timezone] ??
        timeZoneDatabase.locations['Asia/Ho_Chi_Minh'];
    final _startDate = TZDateTime(
      currentLocation!,
      startDate.year,
      startDate.month,
      startDate.day,
      startDate.hour,
      startDate.minute,
      startDate.second,
      startDate.millisecond,
      startDate.microsecond,
    );
    final _endDate = TZDateTime(
      currentLocation,
      endDate.year,
      endDate.month,
      endDate.day,
      endDate.hour,
      endDate.minute,
      endDate.second,
      endDate.millisecond,
      endDate.microsecond,
    );
    return _deviceCalendarPlugin
        .createOrUpdateEvent(
      Event(
        calendar.id,
        start: _startDate,
        end: _endDate,
        title: title,
        description: description,
        location: location,
      ),
    )
        .then((value) {
      LogUtils.d(value?.errors.map((e) => e.errorMessage).join('\n'));
      return value?.isSuccess == true;
    });
  }
}
