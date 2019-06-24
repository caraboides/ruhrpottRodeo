import 'package:flutter/material.dart';

import 'i18n.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(i18n.schedule),
            leading: Icon(Icons.calendar_today),
            onTap: () => navigator.pushReplacementNamed('home'),
          ),
          ListTile(
            title: Text(i18n.mySchedule),
            leading: Icon(Icons.favorite),
            onTap: () => navigator.pushReplacementNamed('mySchedule'),
          ),
          ListTile(
            title: Text(i18n.news),
            leading: Icon(Icons.new_releases),
            onTap: () => navigator.pushReplacementNamed('news'),
          ),
          ListTile(
            title: Text(i18n.faq),
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
