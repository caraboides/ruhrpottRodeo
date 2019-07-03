import 'package:flutter/material.dart';

import 'i18n.dart';

class Menu extends StatelessWidget {
  const Menu();

  bool _isHomeScreen(Route route) =>
      route.settings.name == '/' ||
      route.settings.name == 'home' ||
      route.settings.name == 'mySchedule';

  void _pushOnHome(NavigatorState navigator, String routeName) {
    navigator.pop();
    navigator.pushNamedAndRemoveUntil(
      routeName,
      _isHomeScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        color: theme.accentColor,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(i18n.schedule, style: theme.textTheme.title),
              leading: Icon(Icons.calendar_today, color: Colors.black87),
              onTap: () {
                navigator.popUntil(_isHomeScreen);
                navigator.pushReplacementNamed('home');
              },
            ),
            ListTile(
              title: Text(i18n.mySchedule, style: theme.textTheme.title),
              leading: Icon(Icons.star, color: Colors.black87),
              onTap: () {
                navigator.popUntil(_isHomeScreen);
                navigator.pushReplacementNamed('mySchedule');
              },
            ),
            ListTile(
              title: Text(i18n.important, style: theme.textTheme.title),
              leading: Icon(Icons.warning, color: Colors.black87),
              onTap: () => _pushOnHome(navigator, 'important'),
            ),
            ListTile(
              title: Text(i18n.drive, style: theme.textTheme.title),
              leading: Icon(Icons.map, color: Colors.black87),
              onTap: () => _pushOnHome(navigator, 'drive'),
            ),
            ListTile(
              title: Text(i18n.faq, style: theme.textTheme.title),
              leading: Icon(Icons.help, color: Colors.black87),
              onTap: () => _pushOnHome(navigator, 'faq'),
            ),
            ListTile(
              title: Text(i18n.about, style: theme.textTheme.title),
              leading: Icon(Icons.info, color: Colors.black87),
              onTap: () => _pushOnHome(navigator, 'about'),
            ),
          ],
        ),
      ),
    );
  }
}
