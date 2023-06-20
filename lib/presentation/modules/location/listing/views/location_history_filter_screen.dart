import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/user.dart';
import '../../../../../domain/entities/date_range.entity.dart';
import '../../../../../domain/entities/location_filter.entity.dart';
import '../../../../../generated/assets.dart';
import '../../../../common_widget/calendar_date_picker.dart';
import '../../../../common_widget/export.dart';
import '../../../../common_widget/footer_widget.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';

class LocationHistoryFilterScreen extends StatefulWidget {
  final LocationFilter filter;

  const LocationHistoryFilterScreen({
    super.key,
    required this.filter,
  });

  @override
  State<LocationHistoryFilterScreen> createState() =>
      _LocationHistoryFilterScreenState();
}

class _LocationHistoryFilterScreenState
    extends State<LocationHistoryFilterScreen> {
  late AppLocalizations trans;
  DateTime? _from;
  DateTime? _to;

  User? _child;

  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _from = widget.filter.dateRange?.from;
    _to = widget.filter.dateRange?.to;
    _child = widget.filter.child;
  }

  @override
  Widget build(BuildContext context) {
    trans = translate(context);
    textTheme = context.textTheme;

    return ScreenForm(
      title: trans.filter,
      headerColor: themeColor.primaryColor,
      titleColor: themeColor.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    _buildSelectChild(),
                    const SizedBox(height: 24),
                    DateInputCalendarPicker(
                      onDateSelected: (date) {
                        setState(() {
                          _from = date;
                        });
                      },
                      hint: trans.selectDate,
                      monthStr: trans.month,
                      title: trans.fromDate,
                      initial: _from,
                      maxDate: _to,
                      calendarIcon: Assets.svg.icCalendar,
                    ),
                    const SizedBox(height: 24),
                    DateInputCalendarPicker(
                      onDateSelected: (date) {
                        setState(() {
                          _to = date;
                        });
                      },
                      hint: trans.selectDate,
                      monthStr: trans.month,
                      title: trans.toDate,
                      initial: _to,
                      minDate: _from,
                      calendarIcon: Assets.svg.icCalendar,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomButtons()
        ],
      ),
    );
  }

  Widget _buildSelectChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          trans.selectChild,
          style: textTheme.inputTitle,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.filter.children.map(_buildChild).toList(),
        ),
      ],
    );
  }

  Widget _buildChild(User e) {
    final isSelected = e.id == _child?.id;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _child = e;
          });
        }
      },
      child: BoxColor(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        color: isSelected ? themeColor.primaryColor : themeColor.white,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImageWrapper.avatar(
                url: e.avatar ?? '',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              e.name ?? '--',
              style: TextStyle(
                color: isSelected ? themeColor.white : themeColor.primaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return FooterWidget(
      child: Row(
        children: [
          Expanded(
            child: ThemeButton.outline(
              context: context,
              title: trans.reset,
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.filter,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ThemeButton.primary(
              context: context,
              title: trans.apply,
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.filter.copyWith(
                    child: _child,
                    dateRange: DateRange(from: _from, to: _to),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
