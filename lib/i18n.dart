import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final String dayOne;
  final String dayTwo;
  final String dayThree;
  final String bands;
  final String schedule;
  final String mySchedule;
  final String drive;
  final String faq;
  final String addEventToSchedule;
  final String removeEventFromSchedule;
  final String locale;

  const AppLocalizations({
    this.dayOne,
    this.dayTwo,
    this.dayThree,
    this.bands,
    this.schedule,
    this.mySchedule,
    this.drive,
    this.faq,
    this.addEventToSchedule,
    this.removeEventFromSchedule,
    this.locale,
  });

  DateFormat format(formatString) => DateFormat(formatString, locale);

  static const delegate = AppLocalizationsDelegate();

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
  schedule: 'Plan',
  mySchedule: 'Mein Plan',
  drive: 'Anfahrt',
  faq: 'FAQ',
  addEventToSchedule: 'Füge Auftritt zum Plan hinzu',
  removeEventFromSchedule: 'Entferne Auftritt vom Plan',
  locale: 'de_DE',
);

const _en = AppLocalizations(
  dayOne: 'Day 1',
  dayTwo: 'Day 2',
  dayThree: 'Day 3',
  bands: 'Bands',
  schedule: 'SCHEDULE',
  mySchedule: 'MY SCHEDULE',
  drive: 'how to find us',
  faq: 'FAQ',
  addEventToSchedule: 'Add gig to schedule',
  removeEventFromSchedule: 'Remove gig from schedule',
  locale: 'en_US',
);
