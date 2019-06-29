import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';
import 'model.dart';

class Bands extends InheritedWidget {
  Bands({
    Key key,
    @required Widget child,
    this.bands,
  }) : super(key: key, child: child);

  final List<BandData> bands;

  @override
  bool updateShouldNotify(Bands oldWidget) => oldWidget.bands != bands;

  static Optional<BandData> of(BuildContext context, String id) {
    Bands data = context.inheritFromWidgetOfExactType(Bands);
    return filter(data.bands, id);
  }

  static Optional<BandData> filter(List<BandData> bands, String id) {
    try {
      return Optional.ofNullable(bands.where((b) => b.id == id).first);
    } catch (e) {
      return Optional.empty();
    }
  }
}

class BandsProvider extends StatefulWidget {
  BandsProvider({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  BandsProviderState createState() => BandsProviderState();
}

class BandsProviderState extends State<BandsProvider> {
  Future<List<BandData>> loadInitialData() async {
    final List<dynamic> json = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("assets/bands.json"));
    return parseEntries(json);
  }

  List<BandData> parseEntries(List<dynamic> json) {
    return json.map<BandData>((entry) => parse(entry)).toList();
  }

  /// List of Items
  List<BandData> _bands = <BandData>[];

  @override
  void initState() {
    super.initState();
    loadInitialData().then((bands) {
      setState(() {
        _bands = bands;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Bands(
      bands: _bands,
      child: widget.child,
    );
  }

  BandData parse(Map<String, dynamic> entry) => BandData(
        id: entry['id'],
        name: entry['name'],
        image: entry['image'],
        spotify: entry['spotify'],
        text: entry['text'],
      );
}
