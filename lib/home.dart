import 'dart:async';

import 'package:flutter/material.dart';

import 'app_storage.dart' as appStorage;
import 'event_detail_view.dart';
import 'event_list_view.dart';
import 'i18n.dart';
import 'menu.dart';
import 'model.dart';
import 'notifications.dart';
import 'schedule.dart';

const _myScheduleFileName = 'my_schedule.txt';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MySchedule _mySchedule = MySchedule();
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _loadMySchedule();
  }

  void _loadMySchedule() async {
    final Map<String, dynamic> json =
        (await appStorage.loadJson(_myScheduleFileName))
            .orElse(<String, int>{});
    setState(() {
      _mySchedule = MySchedule(json.cast<String, int>());
    });
    _checkScheduledEventNotifications();
  }

  void _saveMySchedule() async {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 200), () {
      appStorage.storeJson(_myScheduleFileName, _mySchedule.toJson());
    });
  }

  void _checkScheduledEventNotifications() {
    final i18n = AppLocalizations.of(context);
    final now = DateTime.now();
    final scheduledEvents = <int, Event>{};
    Schedule.allBandsOf(context).forEach((event) {
      _mySchedule.getEventNotificationId(event.id).ifPresent((notificationId) {
        if (event.start.isAfter(now)) {
          scheduledEvents[notificationId] = event;
        }
      });
    });
    verifyScheduledEventNotifications(i18n, scheduledEvents);
  }

  Future<void> _toggleEvent(event) async {
    _mySchedule.toggleEvent(
      event.id,
      onRemove: cancelNotification,
      getValueToInsert: () async {
        return event.start.isAfter(DateTime.now())
            ? await scheduleNotificationForEvent(
                AppLocalizations.of(context), event)
            : 0;
      },
      onUpdate: () {
        this.setState(() {});
        _saveMySchedule();
      },
    );
  }

  void _openEventDetails(Event event) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => EventDetailView(event),
      fullscreenDialog: true,
    ));
  }

  Widget _buildEventList(EventFilter eventFilter, {bool bandView = false}) {
    return EventListView(
      eventFilter: eventFilter,
      mySchedule: _mySchedule,
      toggleEvent: _toggleEvent,
      bandView: bandView,
      openEventDetails: _openEventDetails,
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
            _buildEventList(Schedule.allBandsOf, bandView: true),
            _buildEventList(Schedule.firstDayOf),
            _buildEventList(Schedule.secondDayOf),
            _buildEventList(Schedule.thirdDayOf),
          ],
        ),
      ),
    );
  }
}
