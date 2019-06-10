import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'strings.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'da'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of Strings.
    return SynchronousFuture<Strings>(Strings(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
