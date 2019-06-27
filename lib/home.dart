import 'package:flutter/material.dart';

import 'app_storage.dart' as appStorage;
import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'schedule.dart';

const _myScheduleFileName = 'my_schedule.txt';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, bool> _likedEvents = {};

  @override
  void initState() {
    super.initState();
    _loadLikedEvents();
  }

  void _loadLikedEvents() async {
    final Map<String, dynamic> json =
        (await appStorage.loadJson(_myScheduleFileName))
            .orElse(<String, bool>{});
    setState(() {
      _likedEvents = json.cast<String, bool>();
    });
  }

  void _saveLikedEvents() async {
    appStorage.storeJson(_myScheduleFileName, _likedEvents);
  }

  void _toggleEvent(String eventId) {
    this.setState(() {
      _likedEvents[eventId] = !(_likedEvents[eventId] ?? false);
    });
    _saveLikedEvents();
  }

  Widget _buildEventList(EventFilter eventFilter, {bool stageview = true}) {
    return EventListView(
      eventFilter: eventFilter,
      likedEvents: _likedEvents,
      toggleEvent: _toggleEvent,
      stageview: stageview,
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
          title: Text('RUHRPOTT RODEO',
              style: TextStyle(
                fontFamily: 'Beer Money',
                fontSize: 26,
              )),
        ),
        body: TabBarView(
          children: [
            _buildEventList(Schedule.allBandsOf, stageview: false),
            _buildEventList(Schedule.firstDayOf),
            _buildEventList(Schedule.secondDayOf),
            _buildEventList(Schedule.thirdDayOf),
          ],
        ),
      ),
    );
  }
}
