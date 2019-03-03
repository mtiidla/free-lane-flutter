import 'package:flutter/material.dart';
import 'package:freelane/ui/swimming_pool_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'FreeLane',
        theme: new ThemeData(
          primaryColor: Colors.white
        ),
        home: SwimmingPoolsWidget());
  }
}
