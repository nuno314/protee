import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/utils.dart';
import '../theme/app_text_theme.dart';
import '../theme/theme_color.dart';
import 'box_color.dart';
import 'expandable_widget.dart';
import 'title_widget.dart';

class DateInputCalendarPicker extends StatefulWidget {
  final void Function()? onTapInputField;
  final void Function(DateTime date) onDateSelected;
  final DateTime? initial;
  final String monthStr;
  final String title;
  final String? hint;
  final String calendarIcon;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Color? iconColor;
  final bool required;

  const DateInputCalendarPicker({
    Key? key,
    this.onTapInputField,
    required this.onDateSelected,
    this.initial,
    required this.monthStr,
    required this.title,
    required this.calendarIcon,
    this.hint,
    this.minDate,
    this.maxDate,
    this.iconColor,
    this.required = false,
  }) : super(key: key);

  @override
  State<DateInputCalendarPicker> createState() =>
      _DateInputCalendarPickerState();
}

class _DateInputCalendarPickerState extends State<DateInputCalendarPicker> {
  DateTime? select;
  final _expandableCtrl = ExpandableController();

  @override
  void initState() {
    select = widget.initial;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DateInputCalendarPicker oldWidget) {
    select = widget.initial;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    select = widget.initial;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _expandableCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return ExpandableWidget(
      onTapHeader: () {
        widget.onTapInputField?.call();
      },
      header: _buildDateInputField(textTheme: textTheme),
      body: TableCalendarDatePicker(
        monthStr: widget.monthStr,
        context: context,
        value: select,
        minDate: widget.minDate,
        maxDate: widget.maxDate,
        onSelected: (date) {
          _expandableCtrl.toggle();
          if (mounted) {
            setState(() {
              select = date;
            });
          }
          widget.onDateSelected(date);
        },
      ),
      textTheme: textTheme,
      controller: _expandableCtrl,
    );
  }

  Widget _buildDateInputField({
    required TextTheme textTheme,
  }) {
    final idTheme = context.theme.inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputTitleWidget(
          title: widget.title,
          required: widget.required == true,
        ),
        const SizedBox(height: 8),
        HighlightBoxColor(
          borderColor: idTheme.border?.borderSide.color,
          borderWidth: idTheme.border?.borderSide.width,
          borderRadius:
              asOrNull<OutlineInputBorder>(idTheme.border)?.borderRadius,
          padding: context.theme.inputDecorationTheme.contentPadding ??
              const EdgeInsets.all(12),
          bgColor: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  select?.toddmmyyyy() ?? widget.hint ?? '',
                  style: textTheme.textInput?.copyWith(
                    color: select != null ? null : themeColor.subText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 32,
                child: SvgPicture.asset(
                  widget.calendarIcon,
                  width: 24,
                  height: 24,
                  color: widget.iconColor ?? themeColor.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TableCalendarDatePicker extends StatelessWidget {
  const TableCalendarDatePicker({
    Key? key,
    required this.monthStr,
    required this.context,
    required this.value,
    required this.onSelected,
    this.minDate,
    this.maxDate,
    this.rangeStart,
    this.rangeEnd,
    this.availableGestures = AvailableGestures.all,
  }) : super(key: key);

  final String monthStr;
  final BuildContext context;
  final DateTime? value;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final AvailableGestures availableGestures;

  final void Function(DateTime selected) onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final dateLocale = context.appDateLocale;
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      rangeStartDay: rangeStart,
      availableGestures: availableGestures,
      rangeEndDay: rangeEnd,
      firstDay: DateTime.utc(2000, 01, 01),
      lastDay: DateTime.utc(2099, 12, 31),
      focusedDay: value ?? DateTime.now(),
      currentDay: value ?? DateTime.now(),
      availableCalendarFormats: {
        CalendarFormat.month: monthStr,
      },
      locale: Localizations.localeOf(context).languageCode,
      onDaySelected: (selectedDay, _) {
        onSelected.call(selectedDay);
      },
      enabledDayPredicate: (day) {
        var check1 = true;
        var check2 = true;
        if (minDate != null) {
          check1 = day.isAfter(minDate!) || day.isSameDay(minDate!);
        }

        if (maxDate != null) {
          check2 = day.isBefore(maxDate!) || day.isSameDay(maxDate!);
        }
        return check1 && check2;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(22.0),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
        titleTextFormatter: (date, locale) => date.customFormat(
          ['$monthStr ', 'mm', ', ', 'yyyy'],
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              dateLocale.daysShort[day.weekday - 1],
              style: textTheme.titleSmall,
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: themeColor.primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: themeColor.primaryColor,
          shape: BoxShape.circle,
        ),
        rangeHighlightColor: themeColor.primaryColorLight,
        rangeStartDecoration: BoxDecoration(
          color: themeColor.primaryColor,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: themeColor.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      calendarFormat: CalendarFormat.month,
    );
  }
}
