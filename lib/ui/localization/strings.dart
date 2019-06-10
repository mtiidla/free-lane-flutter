import 'dart:ui';

import 'package:flutter/material.dart';

class Strings {
  Strings(this.locale);

  final Locale locale;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  // It is possible to automate the string generation via dart's intl tools,
  // but given the small amount of localized strings needed for this app,
  // the constant list might work just fine.
  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "app_name": "Free Lane",
      "home_screen_title": "Free Lane pools",
      "closed": "Closed",
      "people": "People"
    },
    "da": {
      "app_name": "Fri Bane",
      "home_screen_title": "Fri Bane svømmehalle",
      "closed": "Lukket",
      "people": "Mennesker"
    },
  };

  String _string(String key) => _localizedValues[locale.languageCode][key];

  String get homeScreenTitle => _string("home_screen_title");

  String get appName => _string("app_name");

  String get closed => _string("closed");

  String get people => _string("people");
}
