import 'package:flutter/material.dart';

import 'i18n.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(i18n.schedule),
            leading: Icon(Icons.calendar_today),
          ),
          ListTile(
            title: Text(i18n.mySchedule),
            leading: Icon(Icons.favorite),
          ),
          ListTile(
            title: Text(i18n.news),
            leading: Icon(Icons.new_releases),
          ),
          ListTile(
            title: Text(i18n.faq),
            leading: Icon(Icons.help),
          ),
          AboutListTile(
            icon: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
