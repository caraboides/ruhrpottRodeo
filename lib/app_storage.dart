import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:optional/optional_internal.dart';
import 'package:path_provider/path_provider.dart';

class AppStorage extends InheritedWidget {
  AppStorage({
    Key key,
    @required Widget child,
    this.getDirectory,
  }) : super(key: key, child: child);

  final ValueGetter<Future<String>> getDirectory;

  Future<File> _getFileHandle(String fileName) async {
    final directory = await getDirectory();
    return File('$directory/$fileName');
  }

  Future<Optional<dynamic>> loadJson(String fileName) async {
    try {
      final file = await _getFileHandle(fileName);
      if (await file.exists()) {
        final fileContent = await file.readAsString();
        print(fileContent);
        final json = jsonDecode(fileContent) ?? {};
        return Optional.of(json);
      }
    } catch (e) {
      print(e);
    }
    return Optional.empty();
  }

  void storeJson(String fileName, dynamic json) async {
    try {
      final file = await _getFileHandle(fileName);
      final fileContent = jsonEncode(json);
      await file.writeAsString(fileContent);
    } catch (e) {
      print(e);
    }
  }

  static AppStorage of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppStorage);
  }

  @override
  bool updateShouldNotify(AppStorage oldWidget) => false;
}

class AppStorageProvider extends StatefulWidget {
  AppStorageProvider({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _AppStorageState createState() => _AppStorageState();
}

class _AppStorageState extends State<AppStorageProvider> {
  String _directory = '';

  Future<String> _getAppStorageDirectory() async {
    if (_directory == '') {
      _directory = (await getApplicationDocumentsDirectory()).path;
    }
    return _directory;
  }

  @override
  Widget build(BuildContext context) {
    return AppStorage(
      getDirectory: _getAppStorageDirectory,
      child: widget.child,
    );
  }
}
