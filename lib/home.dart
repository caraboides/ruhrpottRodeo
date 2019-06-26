import 'package:flutter/material.dart';

import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'schedule.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, bool> _likedEvents = {};

  void _toggleEvent(String eventId) {
    this.setState(() {
      _likedEvents[eventId] = !(_likedEvents[eventId] ?? false);
    });
  }

  Widget _buildEventList(EventFilter eventFilter) {
    return EventListView(
      eventFilter: Schedule.allBandsOf,
      likedEvents: _likedEvents,
      toggleEvent: _toggleEvent,
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
          title: Text('Ruhrpott Rodeo'),
        ),
        body: TabBarView(
          children: [
            _buildEventList(Schedule.allBandsOf),
            _buildEventList(Schedule.firstDayOf),
            _buildEventList(Schedule.secondDayOf),
            _buildEventList(Schedule.thirdDayOf),
          ],
        ),
      ),
    );
  }
}
