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
                children: Schedule.of(context)
                    .map((event) => Text(event.bandName))
                    .toList()),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.music_note),
          ],
        ),
      ),
    );
  }
}
