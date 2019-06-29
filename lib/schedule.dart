import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class Schedule extends InheritedWidget {
  Schedule({
    Key key,
    @required Widget child,
    this.events,
  }) : super(key: key, child: child);

  final List<Event> events;

  static List<T> sort<T>(Iterable<T> list, int compare(T a, T b)) {
    List<T> willBeSorted = List.from(list);
    willBeSorted.sort(compare);
    return willBeSorted;
  }

  static List<Event> of(BuildContext context) {
    Schedule schedule = context.inheritFromWidgetOfExactType(Schedule);
    return schedule.events;
  }

  static List<Event> allBandsOf(BuildContext context) {
    return sort(of(context), (a, b) => a.bandName.compareTo(b.bandName));
  }

  static List<Event> firstDayOf(BuildContext context) {
    return sort(of(context).where((item) => item.start.day == 5),
        (a, b) => a.start.compareTo(b.start));
  }

  static List<Event> secondDayOf(BuildContext context) {
    return sort(of(context).where((item) => item.start.day == 6),
        (a, b) => a.start.compareTo(b.start));
  }

  static List<Event> thirdDayOf(BuildContext context) {
    return sort(of(context).where((item) => item.start.day == 7),
        (a, b) => a.start.compareTo(b.start));
  }

  @override
  bool updateShouldNotify(Schedule oldWidget) => oldWidget.events != events;
}

class ScheduleProvider extends StatefulWidget {
  ScheduleProvider({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  ScheduleProviderState createState() => ScheduleProviderState();
}

class ScheduleProviderState extends State<ScheduleProvider> {
  Future<List<Event>> loadInitialData() async {
    final List<dynamic> json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/initialSchedule.json"));
    return parseEvents(json);
  }

  parseEvents(List<dynamic> json) {
    return json
        .expand<Event>((stageDay) => stageDay['timeSlots']
            .where((entry) => !entry['placeholder'])
            .map<Event>((entry) => buildEvent(stageDay, entry))
            .toList())
        .toList();
  }

  Future<List<Event>> loadRemoteData() async {
    final response =
        await http.get('https://ruhrpott-rodeo.app-domain.de/app/days');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      final List<dynamic> json = jsonDecode(response.body);
      return parseEvents(json);
    } else {
      return List<Event>();
    }
  }

  /// List of Items
  List<Event> _events = <Event>[];

  @override
  void initState() {
    super.initState();
    loadInitialData().then((newEvents) {
      loadRemoteData().then((newEvents) {
        setState(() {
          _events = newEvents;
        });
      });
      setState(() {
        _events = newEvents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Schedule(
      events: _events,
      child: widget.child,
    );
  }

  /*
    "name": "Ruhrpott Stage",
    "date": "2019-07-04T22:00:00.000+0000",
    "timeSlots": [
      {
        "id": "061b56f5-3688-4a33-a21f-37e418a3e0cd",
        "name": "Change Over",
        "descriptionText": null,
        "placeholder": true,
        "startTime": "2019-07-05T11:00:00.000+0000",
        "": "2019-07-05T13:24:00.000+0000",
        "created": "2019-01-10T11:16:52.000+0000",
        "updated": "2019-01-10T11:16:52.000+0000"
      },
    */
  Event buildEvent(Map<String, dynamic> stageDay, Map<String, dynamic> entry) =>
      Event(
        bandName: entry['name'],
        description: entry['descriptionText'],
        id: entry['id'],
        stage: stageDay['name'],
        start: DateTime.parse(entry['startTime']),
        end: DateTime.parse(entry['endTime']),
      );
}
