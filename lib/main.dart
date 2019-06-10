import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freelane/ui/localization/strings.dart';
import 'package:freelane/ui/swimming_pool_list.dart';
import 'package:freelane/ui/localization/localization_delegate.dart';

import 'di/ServiceLocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ServiceLocator serviceLocator = ServiceLocator.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateTitle: (BuildContext context) => Strings.of(context).appName,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('da'), // Danish
        ],
        theme: new ThemeData(primaryColor: Colors.white, fontFamily: 'Josefin'),
        home: SwimmingPoolsWidget(serviceLocator.swimmingPoolRepository));
  }
}
