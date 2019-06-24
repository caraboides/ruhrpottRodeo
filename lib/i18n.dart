import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final String dayOne;
  final String dayTwo;
  final String dayThree;
  final String bands;

  static const delegate = AppLocalizationsDelegate();

  const AppLocalizations({
    this.dayOne,
    this.dayTwo,
    this.dayThree,
    this.bands,
  });

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
        locale.languageCode == 'de' ? _de : _en);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

const _de = AppLocalizations(
  dayOne: 'Tag 1',
  dayTwo: 'Tag 2',
  dayThree: 'Tag 3',
  bands: 'Bands',
);

const _en = AppLocalizations(
  dayOne: 'Day 1',
  dayTwo: 'Day 2',
  dayThree: 'Day 3',
  bands: 'Bands',
);
