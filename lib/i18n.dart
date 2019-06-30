import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const timeFormatString = 'HH:mm';
const dateTimeFormatString = 'E HH:mm';

class AppLocalizations {
  final String dayOne;
  final String dayTwo;
  final String dayThree;
  final String bands;
  final String schedule;
  final String mySchedule;
  final String drive;
  final String important;
  final String faq;
  final String addEventToSchedule;
  final String removeEventFromSchedule;
  final String locale;
  final String eventDetailsHeader;
  final String eventNotificationFormat;
  final String about;
  final String aboutLicense;
  final String aboutCreated;
  final String noInfo;

  // final DateFormat timeFormat;
  // final DateFormat dateTimeFormat;

  AppLocalizations({
    this.dayOne,
    this.dayTwo,
    this.dayThree,
    this.bands,
    this.schedule,
    this.mySchedule,
    this.drive,
    this.important,
    this.faq,
    this.addEventToSchedule,
    this.removeEventFromSchedule,
    this.locale,
    this.eventDetailsHeader,
    this.eventNotificationFormat,
    this.about,
    this.aboutLicense,
    this.aboutCreated,
    this.noInfo,
  }) /*: TODO(SF) why does this not work?
        this.timeFormat = DateFormat(timeFormatString, locale),
        this.dateTimeFormat = DateFormat(dateTimeFormatString, locale)*/
  ;

  DateFormat get timeFormat => DateFormat(timeFormatString, locale);
  DateFormat get dateTimeFormat => DateFormat(dateTimeFormatString, locale);

  String eventNotification(String bandName, DateTime time, String stage) =>
      eventNotificationFormat
          .replaceAll('{band}', bandName)
          .replaceAll('{time}', timeFormat.format(time))
          .replaceAll('{stage}', stage);

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
        locale.languageCode == 'de' ? de : en);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

final de = AppLocalizations(
  dayOne: 'Tag 1',
  dayTwo: 'Tag 2',
  dayThree: 'Tag 3',
  bands: 'Bands',
  schedule: 'PLAN',
  mySchedule: 'MEIN >PLAN',
  drive: 'ANFAHRT',
  important: 'WICHTIG',
  faq: 'FAQ',
  addEventToSchedule: 'Füge Auftritt zum Plan hinzu',
  removeEventFromSchedule: 'Entferne Auftritt vom Plan',
  locale: 'de_DE',
  eventDetailsHeader: 'BAND DETAILS',
  eventNotificationFormat: '{band} spielen um {time} auf der {stage}!',
  about: 'ÜBER DIESE APP',
  aboutLicense: 'Copyright 2019 Christian ❤ Stephanie',
  aboutCreated: 'Entwickelt von',
  noInfo: 'Sorry, keine Infos',
);

final en = AppLocalizations(
  dayOne: 'Day 1',
  dayTwo: 'Day 2',
  dayThree: 'Day 3',
  bands: 'Bands',
  schedule: 'SCHEDULE',
  mySchedule: 'MY >SCHEDULE',
  drive: 'LOCATION',
  important: 'IMPORTANT',
  faq: 'FAQ',
  addEventToSchedule: 'Add gig to schedule',
  removeEventFromSchedule: 'Remove gig from schedule',
  locale: 'en_US',
  eventDetailsHeader: 'BAND DETAILS',
  eventNotificationFormat: '{band} plays at {time} on the {stage}!',
  about: 'ABOUT',
  aboutLicense: 'Copyright 2019 Christian ❤ Stephanie',
  aboutCreated: 'Created by',
  noInfo: 'Sorry, no info',
);
