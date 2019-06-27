import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ruhrpott_rodeo/faq.dart';

import 'app_storage.dart';
import 'home.dart';
import 'i18n.dart';
import 'my_schedule.dart';
import 'drive.dart';
import 'schedule.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppStorageProvider(
      child: ScheduleProvider(
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
            const Locale('en'),
            const Locale('de'),
          ],
          initialRoute: 'home',
          routes: {
            'home': (context) => HomeScreen(),
            'mySchedule': (context) => MySchedule(),
            'drive': (context) => Drive(),
            'faq': (context) => FAQ(),
          },
        ),
      ),
    );
  }
}
