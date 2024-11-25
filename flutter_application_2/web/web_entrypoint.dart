// web/web_entrypoint.dart
import 'package:TragoVoltaje/main.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}