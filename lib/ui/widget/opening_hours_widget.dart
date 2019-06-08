import 'package:flutter/material.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:intl/intl.dart';

class ExpandingOpeningHours extends StatelessWidget {
  final List<OpeningHours> openingHours;
  final List<DateTime> daysOfWeek;
  final DateFormat weekdayFormat = DateFormat.EEEE();

  ExpandingOpeningHours(this.openingHours)
      : this.daysOfWeek = _createDaysOfWeek();

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
    return ExpansionTile(
      title: widgets[0],
      children: widgets.sublist(1, widgets.length)
          .map((c) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: c,
              ))
          .toList(),
    );
  }
}
