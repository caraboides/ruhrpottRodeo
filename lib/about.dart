import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu.dart';

class About extends StatelessWidget {
  Widget _buildLink(ThemeData theme, String url) => FlatButton(
        textColor: theme.accentColor,
        child: Text(url),
        onPressed: () => launch(url),
      );

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text(
          i18n.about,
          style: theme.textTheme.display1,
        ),
      ),
      body: Column(
        children: <Widget>[
          Text('This is an unofficial app for the Ruhrpott Rodeo Festival'),
          _buildLink(theme, 'https://www.ruhrpott-rodeo.de'),
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
                  _buildLink(theme, 'https://github.com/strangeAeon'),
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
                  _buildLink(theme, 'http://www.rolandhuse.com'),
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
              _buildLink(theme, 'https://www.example.com'),
            ],
          ),
          RaisedButton(
            color: theme.accentColor,
            child:
                Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
            onPressed: () {
              showLicensePage(
                context: context,
                applicationName: 'RODEO APP',
                applicationVersion: '1.0.0',
                applicationLegalese: i18n.aboutLicense,
              );
            },
          ),
        ],
      ),
    );
  }
}
