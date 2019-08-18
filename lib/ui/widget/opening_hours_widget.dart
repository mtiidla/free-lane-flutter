import 'package:flutter/material.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:freelane/ui/localization/strings.dart';
import 'package:intl/intl.dart';

class ExpandingOpeningHours extends StatelessWidget {
  final List<DateTime> _daysOfWeek;
  final List<OpeningHours> openingHours;

  ExpandingOpeningHours(this.openingHours)
      : this._daysOfWeek = _createDaysOfWeek();

  static List<DateTime> _createDaysOfWeek() {
    List<DateTime> daysOfWeek = new List();
    DateTime now = new DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day);
    for (int i = 0; i < 7; i++) {
      daysOfWeek.add(today.add(Duration(days: i)));
    }
    return daysOfWeek;
  }

  @override
  Widget build(BuildContext context) {
    List dayWidgets = new List<Widget>();
    var weekdayFormat =
        DateFormat.EEEE(Localizations.localeOf(context).languageCode);
    DateTime today = DateTime.now();
    for (var dayOfWeek in _daysOfWeek) {
      String day = weekdayFormat.format(dayOfWeek);
      var daysOpeningHoursList =
          openingHours.where((hour) => hour.date == dayOfWeek);
      var isToday = today.weekday == dayOfWeek.weekday;
      if (daysOpeningHoursList.isEmpty) {
        var hours = Strings.of(context).closed.toLowerCase();
        dayWidgets.add(_buildDayHoursRow(isToday, day, hours));
      } else {
        List<Widget> daySubWidgets = new List<Widget>();
        for (var daysOpeningHours in daysOpeningHoursList) {
          String hours = daysOpeningHours.toRangeString();
          if (daysOpeningHours.label == null) {
            dayWidgets.add(_buildDayHoursRow(isToday, day, hours));
          } else {
            String label = daysOpeningHours.label;
            daySubWidgets.add(_buildDayHoursSubLabelRow(label, hours));
          }
        }
        if(daySubWidgets.isNotEmpty) {
          _wrapLastWidgetInPadding(daySubWidgets, EdgeInsets.only(bottom: 8));
          dayWidgets.addAll(daySubWidgets);
        }
      }
    }

    _wrapLastWidgetInPadding(dayWidgets, EdgeInsets.only(bottom: 8));
    return ExpansionTile(
      title: dayWidgets[0],
      children: dayWidgets
          .sublist(1, dayWidgets.length)
          .map((c) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: c))
          .toList(),
    );
  }

  Widget _buildDayHoursRow(bool isToday, String day, String hours) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        isToday
            ? Text(day, style: TextStyle(fontWeight: FontWeight.bold))
            : Text(day),
        Text(hours)
      ],
    );
  }

  Widget _buildDayHoursSubLabelRow(String label, String hours) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text("• $label"), Text("$hours")],
    );
  }

  void _wrapLastWidgetInPadding(List<Widget> widgets, EdgeInsets insets) {
    widgets[widgets.length - 1] =
        new Padding(padding: insets, child: widgets[widgets.length - 1]);
  }
}
