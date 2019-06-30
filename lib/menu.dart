import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          title: Text(i18n.important, style: textStyle),
          leading: Icon(Icons.warning),
          onTap: () => navigator.pushReplacementNamed('important'),
          ),
          ListTile(
            title: Text(i18n.drive, style: textStyle),
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
            child: Text(i18n.about, style: textStyle),
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
    );
  }

  Widget _buildLink(String url) => FlatButton(
        child: Text(url),
        onPressed: () => launch(url),
      );

  List<Widget> _buildAboutContent(AppLocalizations i18n) => <Widget>[
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
