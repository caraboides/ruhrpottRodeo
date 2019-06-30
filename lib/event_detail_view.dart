import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';

import 'band.dart';
import 'i18n.dart';
import 'model.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final Optional<BandData> data = Bands.of(context, event.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          i18n.eventDetailsHeader,
          style: theme.textTheme.headline,
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Text(
              event.bandName,
              style: theme.textTheme.display1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(data.map((a) => a.text).orElse(i18n.noInfo)),
            ),
            data
                .map<Widget>((d) => RaisedButton(
                      onPressed: () {
                        launch(d.spotify);
                      },
                      child: Text(
                        "Play on Spotify",
                      ),
                    ))
                .orElse(Container()),
            //data.map((d) => Image.network(d.image)).orElse(Image.asset("")),
          ],
        ),
      ),
    );
  }
}
