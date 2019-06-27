import 'package:flutter/material.dart';

import 'i18n.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    const textStyle = TextStyle(fontFamily: 'Beer Money', fontSize: 24);
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(i18n.schedule, style: textStyle),
            leading: Icon(Icons.calendar_today),
            onTap: () => navigator.pushReplacementNamed('home'),
          ),
          ListTile(
            title: Text(i18n.mySchedule, style: textStyle),
            leading: Icon(Icons.favorite),
            onTap: () => navigator.pushReplacementNamed('mySchedule'),
          ),
          ListTile(
            title: Text(i18n.drive),
            leading: Icon(Icons.map),
            onTap: () => navigator.pushReplacementNamed('drive'),
          ),
          ListTile(
            title: Text(i18n.faq, style: textStyle),
            leading: Icon(Icons.help),
            onTap: () => navigator.pushReplacementNamed('faq'),
          ),
          AboutListTile(
            icon: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
