import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu.dart';

class About extends StatelessWidget {
  Widget _buildLink(ThemeData theme, String url,
          {String label, bool shrink: false}) =>
      FlatButton(
        textColor: theme.accentColor,
        child: Text(label ?? url),
        onPressed: () => launch(url),
        materialTapTargetSize: shrink
            ? MaterialTapTargetSize.shrinkWrap
            : MaterialTapTargetSize.padded,
      );

  Widget _buildCreator(
    String name,
    List<Widget> links, {
    bool heartIcon = false,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            heartIcon ? Icons.favorite : Icons.stars,
            color: heartIcon ? Colors.purple : Colors.black87,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(name),
              ),
              ...links,
            ],
          )
        ],
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
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text('This is an unofficial app for the Ruhrpott Rodeo Festival:'),
          Align(
            alignment: Alignment.center,
            child: _buildLink(theme, 'https://www.ruhrpott-rodeo.de'),
          ),
          Text('Source code can be found under'),
          Align(
            alignment: Alignment.center,
            child: _buildLink(
                theme, 'https://github.com/caraboides/ruhrpott_rodeo'),
          ),
          Divider(),
          SizedBox(height: 5),
          Text(i18n.aboutCreated),
          SizedBox(height: 10),
          _buildCreator(
            'Christian Hennig',
            <Widget>[
              _buildLink(theme, 'https://github.com/caraboides', shrink: true),
              _buildLink(theme, 'https://twitter.com/carabiodes',
                  label: '@carabiodes', shrink: true),
            ],
            heartIcon: true,
          ),
          _buildCreator(
            'Stephanie Freitag',
            <Widget>[
              _buildLink(theme, 'https://github.com/strangeAeon', shrink: true),
            ],
            heartIcon: true,
          ),
          _buildCreator('Daniel Scheibe', <Widget>[]),
          Divider(),
          SizedBox(height: 5),
          _buildCreator('Font "Beer Money" by:', <Widget>[
            _buildLink(theme, 'http://www.rolandhuse.com', shrink: true),
          ]),
          _buildCreator('Wikipedia', <Widget>[]),
          Divider(),
          SizedBox(height: 5),
          Text('Seenotrettung ist kein Verbrechen!'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildLink(theme, 'https://sea-watch.org/'),
            ],
          ),
          RaisedButton(
            color: theme.accentColor,
            child:
                Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
            onPressed: () {
              showLicensePage(
                context: context,
                applicationName: 'RUHRPOTT RODEO APP',
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
