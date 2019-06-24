import 'package:flutter/material.dart';

import 'menu.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Center(
        child: Text('FAQ Content'),
      ),
    );
  }
}
