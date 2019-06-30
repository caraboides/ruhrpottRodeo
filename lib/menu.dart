import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'i18n.dart';

class Menu extends StatelessWidget {
  const Menu();

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
              onTap: () => navigator.pushReplacementNamed('home'),
            ),
            ListTile(
              title: Text(i18n.mySchedule, style: theme.textTheme.title),
              leading: Icon(Icons.star, color: Colors.black87),
              onTap: () => navigator.pushReplacementNamed('mySchedule'),
            ),
            ListTile(
              title: Text(i18n.important, style: theme.textTheme.title),
              leading: Icon(Icons.warning, color: Colors.black87),
              onTap: () => navigator.pushReplacementNamed('important'),
            ),
            ListTile(
              title: Text(i18n.drive, style: theme.textTheme.title),
              leading: Icon(Icons.map, color: Colors.black87),
              onTap: () => navigator.pushReplacementNamed('drive'),
            ),
            ListTile(
              title: Text(i18n.faq, style: theme.textTheme.title),
              leading: Icon(Icons.help, color: Colors.black87),
              onTap: () => navigator.pushReplacementNamed('faq'),
            ),
            AboutListTile(
              icon: Icon(Icons.info, color: Colors.black87),
              child: Text(i18n.about, style: theme.textTheme.title),
              applicationName: 'Ruhrpott Rodeo',
              applicationVersion: '1.0.0',
              applicationIcon: Image.asset(
                'assets/app_logo.png',
                height: 60,
              ),
              applicationLegalese: i18n.aboutLicense,
              aboutBoxChildren: _buildAboutContent(i18n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String url) => FlatButton(
        child: Text(url),
        onPressed: () => launch(url),
      );

  List<Widget> _buildAboutContent(AppLocalizations i18n) => <Widget>[
        Text('This is an unofficial app for the Ruhrpott Rodeo Festival'),
        _buildLink('https://www.ruhrpott-rodeo.de'),
        Text(i18n.aboutCreated),
        Row(
          children: <Widget>[
            Text('*'),
            Text('CH'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('*'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Stephanie Freitag:'),
                _buildLink('https://github.com/strangeAeon'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('*'),
            Text('DS'),
          ],
        ),
        Text('Other worthy mentions:'),
        Row(
          children: <Widget>[
            Text('*'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Font "Beer Money" by:'),
                _buildLink('http://www.rolandhuse.com'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('*'),
            Text('Wikipedia'),
          ],
        ),
        Text('Recycle your animals!'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Save the oceans:'),
            _buildLink('https://www.example.com'),
          ],
        ),
      ];
}
