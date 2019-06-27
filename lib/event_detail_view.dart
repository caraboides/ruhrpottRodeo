import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/i18n.dart';

import 'model.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.eventDetailsHeader,
            style: TextStyle(
              fontFamily: 'Beer Money',
              fontSize: 26,
            )),
      ),
      body: Column(
        children: <Widget>[
          Text(event.bandName),
          Text(event.description ?? ''),
          Image.asset('assets/app_logo-1024.png'),
        ],
      ),
    );
  }
}
