import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n.dart';
import 'event_list_view.dart';
import 'schedule.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScheduleProvider(
      child: MaterialApp(
        title: 'Ruhrpott Rodeo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: HomeScreen(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('de'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: i18n.bands),
              Tab(text: i18n.dayOne),
              Tab(text: i18n.dayTwo),
              Tab(text: i18n.dayThree),
            ],
          ),
          title: Text('Ruhrpott Rodeo'),
        ),
        body: TabBarView(
          children: [
            EventListView(
              eventFilter: Schedule.allBandsOf,
            ),
             EventListView(
              eventFilter: Schedule.firstDayOf,
            ),
             EventListView(
              eventFilter: Schedule.secondDayOf,
            ),
            EventListView(
              eventFilter: Schedule.thirdDayOf,
            ),
          ],
        ),
      ),
    );
  }
}
