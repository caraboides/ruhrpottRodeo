import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';

import 'band.dart';
import 'i18n.dart';
import 'model.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final Optional<BandData> data = Bands.of(context, event.id);
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
          Text(event.bandName,
              style: TextStyle(
                fontFamily: 'Beer Money',
                fontSize: 28,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(data.map((a) => a.text).orElse("Sorry no Infos")),
          ),
          data.map((d) => Image.network(d.image)).orElse(Image.asset("")),
        ],
      ),
    );
  }
}
