import 'package:flutter/material.dart';

import 'menu.dart';

class MySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('My Schedule'),
      ),
      body: Center(
        child: Text('My Schedule Content'),
      ),
    );
  }
}
