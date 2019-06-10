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
    DateTime today = DateTime.now();
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
      var daysOpeningHours = openingHours.firstWhere(
          (hour) => hour.dayOfWeek == dayOfWeek.weekday,
          orElse: () => null);
      String hours = daysOpeningHours == null
          ? Strings.of(context).closed.toLowerCase()
          : daysOpeningHours.toRangeString();
      dayWidgets.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            today.weekday == dayOfWeek.weekday
                ? Text(day, style: TextStyle(fontWeight: FontWeight.bold))
                : Text(day),
            Text(hours)
          ],
        ),
      );
    }
    return ExpansionTile(
      title: dayWidgets[0],
      children: dayWidgets
          .sublist(1, dayWidgets.length)
          .map((c) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: c,
              ))
          .toList(),
    );
  }
}
