import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_application_2/main.dart' as app;

void main() {
  setUrlStrategy(PathUrlStrategy());
  app.main();
}
