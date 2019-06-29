import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/i18n.dart';
import 'package:ruhrpott_rodeo/weather.dart';
import 'model.dart';

typedef EventFilter = List<Event> Function(BuildContext context);

class EventListView extends StatelessWidget {
  final EventFilter eventFilter;
  final MySchedule mySchedule;
  final ValueChanged<Event> toggleEvent;
  final bool bandView;
  final ValueChanged<Event> openEventDetails;

  const EventListView({
    Key key,
    this.eventFilter,
    this.mySchedule,
    this.toggleEvent,
    this.bandView,
    this.openEventDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = eventFilter(context)
        .map((event) => CustomListItemTwo(
              isLiked: mySchedule.isEventLiked(event.id),
              bandname: event.bandName,
              start: event.start,
              stage: event.stage,
              toggleEvent: () => toggleEvent(event),
              bandView: bandView,
              openEventDetails: () => openEventDetails(event),
            ))
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        WeatherWidget(date: "foo"),
        Expanded(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: items,
            ).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.isLiked,
    this.bandname,
    this.start,
    this.stage,
    this.toggleEvent,
    this.bandView,
    this.openEventDetails,
  }) : super(key: key);

  final bool isLiked;
  final String bandname;
  final DateTime start;
  final String stage;
  final VoidCallback toggleEvent;
  final bool bandView;
  final VoidCallback openEventDetails;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return InkWell(
      onTap: openEventDetails,
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                tooltip: isLiked
                    ? i18n.removeEventFromSchedule
                    : i18n.addEventToSchedule,
                onPressed: toggleEvent,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _EventDescription(
                    bandname: bandname,
                    start: start,
                    stage: stage,
                    bandView: bandView,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDescription extends StatelessWidget {
  _EventDescription({
    Key key,
    this.bandname,
    this.start,
    this.stage,
    this.bandView,
  }) : super(key: key);

  final String bandname;
  final DateTime start;
  final String stage;
  final bool bandView;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final formatter = bandView ? i18n.dateTimeFormat : i18n.timeFormat;
    return Column(
      crossAxisAlignment: bandView || stage == "Ruhrpott Stage"
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          bandname,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Text(
          '${formatter.format(start.toLocal())}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
        Text(
          stage,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
