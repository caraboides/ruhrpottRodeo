import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'band.dart';
import 'faq.dart';
import 'home.dart';
import 'i18n.dart';
import 'initialization.dart';
import 'drive.dart';
import 'my_schedule.dart';
import 'my_schedule_view.dart';
import 'notifications.dart';
import 'schedule.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeNotifications();
    return ScheduleProvider(
      child: MyScheduleProvider(
        child: BandsProvider(
          child: MaterialApp(
            title: 'Ruhrpott Rodeo',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('de', 'DE'),
            ],
            home: InitializationWidget(
              child: HomeScreen(),
            ),
            routes: {
              'home': (context) => HomeScreen(),
              'mySchedule': (context) => MyScheduleView(),
              'drive': (context) => Drive(),
              'faq': (context) => FAQ(),
            },
          ),
        ),
      ),
    );
  }
}
