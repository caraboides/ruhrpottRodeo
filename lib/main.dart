import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'about.dart';
import 'band.dart';
import 'faq.dart';
import 'home.dart';
import 'i18n.dart';
import 'important.dart';
import 'initialization.dart';
import 'drive.dart';
import 'my_schedule.dart';
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
              primaryColor: Color(0xFFDE0000),
              accentColor: Color(0xFFFFA419),
              //accentColor: Color(0xFFFB9802),
              textTheme: Typography.blackMountainView.copyWith(
                headline: TextStyle(
                  fontFamily: 'Beer Money',
                  fontSize: 28,
                  color: Colors.black,
                ),
                display1: TextStyle(
                  fontFamily: 'Beer Money',
                  fontSize: 26,
                  color: Colors.white,
                ),
                title: TextStyle(
                  fontFamily: 'Beer Money',
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
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
              'mySchedule': (context) => HomeScreen(favoritesOnly: true),
              'drive': (context) => Drive(),
              'faq': (context) => FAQ(),
              'important': (context) => Important(),
              'about': (context) => About(),
            },
          ),
        ),
      ),
    );
  }
}
