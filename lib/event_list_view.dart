import 'package:flutter/material.dart';

import 'model.dart';

typedef EventFilter = List<Event> Function(BuildContext context);

class EventListView extends StatelessWidget {
  final EventFilter eventFilter;

  const EventListView({Key key, this.eventFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: eventFilter(context)
          .map((event) => ListTile(
                title: Text(event.bandName),
              ))
          .toList(),
    );
  }
}
