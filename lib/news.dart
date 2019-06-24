import 'package:flutter/material.dart';

import 'menu.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Center(
        child: Text('News Content'),
      ),
    );
  }
}
