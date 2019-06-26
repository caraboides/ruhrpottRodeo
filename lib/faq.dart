import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/model.dart';

import 'menu.dart';




class FAQ extends StatelessWidget {



  parseFaqs(List<dynamic> json) {
    return json
        .map<Faq>((faq) => Faq(question: faq['question'],answer: faq['answer']))
        .toList();
  }

  Future<List<Faq>> loadFaq(BuildContext context) async {
    final List<dynamic> json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/initialFaq.json"));
    return parseFaqs(json);
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Faq>> data = loadFaq(context);
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body:FutureBuilder<List<Faq>>(
       future: data, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Faq>> list) {
        switch (list.connectionState) {
           case ConnectionState.none:
           case ConnectionState.active:
           case ConnectionState.waiting:
             return Text('Awaiting result...');
           case ConnectionState.done:
             if (list.hasError)
               return Text('Error: ${list.error}');
             return ListView(
               children: ListTile.divideTiles(
                 context: context,
                 tiles: list.data
                     .map((faq) => ListTile(title: Text(faq.question),subtitle:Text( faq.answer)))
                     .toList(),
               ).toList(),
             );;
         }
         return null; // unreachable
       },
    ),
    );
  }
}
