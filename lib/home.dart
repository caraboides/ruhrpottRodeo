import 'package:flutter/material.dart';

import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'schedule.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const Menu(),
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
