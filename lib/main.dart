import 'package:flutter/material.dart';
import 'package:freelane/ui/swimming_pool_list.dart';

import 'di/ServiceLocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final ServiceLocator serviceLocator = ServiceLocator.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'FreeLane',
        theme: new ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Josefin'
        ),
        home: SwimmingPoolsWidget(serviceLocator.swimmingPoolRepository));
  }
}
