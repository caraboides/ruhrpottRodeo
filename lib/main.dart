import 'package:flutter/material.dart';

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
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Bands"),
              Tab(text: "Day1"),
              Tab(text: "Day2"),
              Tab(text: "Day3"),
            ],
          ),
          title: Text('Ruhrpott Rodeo'),
        ),
        body: TabBarView(
          children: [
            ListView(
                children: Schedule.allBandsOf(context)
                    .map((event) => Text(event.bandName))
                    .toList()),
            ListView(
                children: Schedule.firstDayOf(context)
                    .map((event) => Text(event.bandName))
                    .toList()),
            ListView(
                children: Schedule.secondDayOf(context)
                    .map((event) => Text(event.bandName))
                    .toList()),
            ListView(
                children: Schedule.thirdDayOf(context)
                    .map((event) => Text(event.bandName))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
