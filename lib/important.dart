import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/i18n.dart';
import 'menu.dart';

class Important extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: Text(
            i18n.important,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        body: Center(child: Image.asset("assets/wichtig.jpg")));
  }
}
