import 'package:flutter/material.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:intl/intl.dart';

class ExpandingOpeningHours extends StatelessWidget {
  final List<Widget> dayWidgets;

  ExpandingOpeningHours(openingHours)
      : this.dayWidgets = _createDayWidgets(
            openingHours, _createDaysOfWeek(), DateFormat.EEEE());

  static List<DateTime> _createDaysOfWeek() {
    List<DateTime> daysOfWeek = new List();
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      daysOfWeek.add(today.add(Duration(days: i)));
    }
    return daysOfWeek;
  }

  static List<Widget> _createDayWidgets(List<OpeningHours> openingHours,
      List<DateTime> daysOfWeek, DateFormat weekdayFormat) {
    List widgets = new List<Widget>();
    DateTime today = DateTime.now();
    for (var dayOfWeek in daysOfWeek) {
      String day = weekdayFormat.format(dayOfWeek);
      var daysOpeningHours = openingHours.firstWhere(
          (hour) => hour.dayOfWeek == dayOfWeek.weekday,
          orElse: () => null);
      String hours = daysOpeningHours == null
          ? "closed"
          : daysOpeningHours.toRangeString();
      widgets.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            today.weekday == dayOfWeek.weekday
                ? Text(
                    day,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(day),
            Text(hours)
          ],
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: dayWidgets[0],
      children: dayWidgets.sublist(1, dayWidgets.length)
          .map((c) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: c,
              ))
          .toList(),
    );
  }
}
