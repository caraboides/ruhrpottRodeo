import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'i18n.dart';
import 'model.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  'your channel id', //TODO(SF) ??
  'your channel name',
  'your channel description',
  importance: Importance.Max,
  priority: Priority.High,
);

void initializeNotifications() {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((details) {
    if (details != null) {
      // TODO(SF) payload always empty?
      onSelectNotification(details.payload);
    }
  });

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, IOSInitializationSettings());
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future onSelectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
  /*TODO(SF) await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
    );*/
}

Future<void> scheduleNotificationForEvent(
    AppLocalizations i18n, Event event) async {
  var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, IOSNotificationDetails());
  await flutterLocalNotificationsPlugin.schedule(
    DateTime.now().millisecondsSinceEpoch ~/ 1000, // TODO(SF) better id?
    'Ruhrpott Rodeo',
    i18n.eventNotification(event.bandName, event.start.toLocal(), event.stage),
    scheduledNotificationDateTime, // TODO(SF) event.start.subtract(Duration(minutes: 10))
    platformChannelSpecifics,
    payload: event.bandName, //TODO(SF) payload necessary?
  );
}
