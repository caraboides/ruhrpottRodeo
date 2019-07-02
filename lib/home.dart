import 'dart:async';

import 'package:flutter/material.dart';

import 'event_detail_view.dart';
import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'model.dart';
import 'schedule.dart';
import 'weather.dart';

class HomeScreen extends StatefulWidget {
  final bool favoritesOnly;

  const HomeScreen({this.favoritesOnly = false});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Timer _rebuildTimer;
  bool favoritesOnly = false;

  @override
  void initState() {
    super.initState();
    favoritesOnly = widget.favoritesOnly;
    WidgetsBinding.instance.addObserver(this);
    _rebuildTimer = _createTimer();
  }

  @override
  void dispose() {
    _rebuildTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.suspending:
        _rebuildTimer.cancel();
        break;
      case AppLifecycleState.resumed:
        _rebuild();
        _rebuildTimer = _createTimer();
        break;
    }
  }

  Timer _createTimer() =>
      Timer.periodic(Duration(minutes: 1), (_) => _rebuild());

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onFavoritesFilterChange(bool newValue) {
    setState(() {
      favoritesOnly = newValue;
    });
  }

  void _openEventDetails(BuildContext context, Event event) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => EventDetailView(event),
      fullscreenDialog: true,
    ));
  }

  Widget _buildEventList(BuildContext context, EventFilter eventFilter,
      {String datum, bool bandView = false}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (datum != null) WeatherWidget(datum),
        EventListView(
          eventFilter: eventFilter,
          bandView: bandView,
          openEventDetails: (event) => _openEventDetails(context, event),
          favoritesOnly: favoritesOnly,
        ),
      ],
    );
  }

  int get _initialTab {
    final now = DateTime.now();
    if (now.year == 2019 && now.month == 7 && now.day >= 5 && now.day <= 7) {
      return now.day - 4;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 4,
      initialIndex: _initialTab,
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
          title: Text(
            'RUHRPOTT RODEO >',
            style: theme.textTheme.display1,
          ),
          actions: <Widget>[
            Icon(favoritesOnly ? Icons.star : Icons.star_border),
            Switch(
              value: favoritesOnly,
              onChanged: _onFavoritesFilterChange,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildEventList(context, Schedule.allBandsOf, bandView: true),
            _buildEventList(context, Schedule.firstDayOf,
                datum: "2019-07-05T14:00:00.000"),
            _buildEventList(context, Schedule.secondDayOf,
                datum: "2019-07-06T14:00:00.000"),
            _buildEventList(context, Schedule.thirdDayOf,
                datum: "2019-07-07T14:00:00.000"),
          ],
        ),
      ),
    );
  }
}
