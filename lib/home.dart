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

class _HomeScreenState extends State<HomeScreen> {
  bool favoritesOnly = false;

  @override
  void initState() {
    super.initState();
    favoritesOnly = widget.favoritesOnly;
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
          actions: <Widget>[
            Icon(favoritesOnly ? Icons.favorite : Icons.favorite_border),
            Switch(
              value: favoritesOnly,
              onChanged: _onFavoritesFilterChange,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildEventList(context, Schedule.allBandsOf, bandView: true),
            _buildEventList(context, Schedule.firstDayOf, datum: "2019-07-03T14:00:00.000"),
            _buildEventList(context, Schedule.secondDayOf, datum: "2019-07-06T14:00:00.000"),
            _buildEventList(context, Schedule.thirdDayOf, datum: "2019-07-07T14:00:00.000"),
          ],
        ),
      ),
    );
  }
}
