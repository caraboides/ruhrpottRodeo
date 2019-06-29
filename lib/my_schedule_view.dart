import 'package:flutter/material.dart';

import 'menu.dart';

class MyScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('MY >SCHEDULE',
            style: TextStyle(
              fontFamily: 'Beer Money',
              fontSize: 26,
            )),
      ),
      body: Center(
        child: Text('My Schedule Content'),
      ),
    );
  }
}
