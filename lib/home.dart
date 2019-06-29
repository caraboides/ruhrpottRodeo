import 'package:flutter/material.dart';

import 'event_detail_view.dart';
import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'model.dart';
import 'schedule.dart';
import 'weather.dart';

class HomeScreen extends StatelessWidget {
  void _openEventDetails(BuildContext context, Event event) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => EventDetailView(event),
      fullscreenDialog: true,
    ));
  }

  Widget _buildEventList(BuildContext context, EventFilter eventFilter,
      {bool bandView = false}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        WeatherWidget(date: "foo"),
        EventListView(
          eventFilter: eventFilter,
          bandView: bandView,
          openEventDetails: (event) => _openEventDetails(context, event),
        ),
      ],
    );
  }

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
          title: Text('RUHRPOTT RODEO >',
              style: TextStyle(
                fontFamily: 'Beer Money',
                fontSize: 26,
              )),
        ),
        body: TabBarView(
          children: [
            _buildEventList(context, Schedule.allBandsOf, bandView: true),
            _buildEventList(context, Schedule.firstDayOf),
            _buildEventList(context, Schedule.secondDayOf),
            _buildEventList(context, Schedule.thirdDayOf),
          ],
        ),
      ),
    );
  }
}
