import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model.dart';

typedef EventFilter = List<Event> Function(BuildContext context);

var formatter = new DateFormat('HH:mm');

class EventListView extends StatelessWidget {
  final EventFilter eventFilter;

  const EventListView({Key key, this.eventFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: eventFilter(context)
            .map((event) => CustomListItemTwo(
                  isLiked:true,
                  bandname: event.bandName,
                  start: event.start,
                  stage: event.stage
                ))
            .toList(),
      ).toList(),
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
   }) : super(key: key);

   final bool isLiked;
   final String bandname;
   final DateTime start;
   final String stage;

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: 10.0),
       child: SizedBox(
         height: 50,
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             AspectRatio(
               aspectRatio: 1.0,
               child: isLiked?Icon(Icons.favorite):Icon(Icons.mood_bad),
             ),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                 child: _EventDescription(
                   bandname: bandname,
                   start: start,
                   stage: stage,
                 ),
               ),
             )
           ],
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
   }) : super(key: key);

   final String bandname;
   final DateTime start;
   final String stage;

   @override
   Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         Expanded(
           flex: 2,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text(
                 '$bandname',
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
             ],
           ),
         ),
         Expanded(
           flex: 1,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               Text(
                 '$stage',
                 style: const TextStyle(
                   fontSize: 12.0,
                   color: Colors.black87,
                 ),
               ),
             ],
           ),
         ),
       ],
     );
   }
 }