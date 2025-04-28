import 'package:flutter/material.dart';
import 'package:nolatech_tenis/app.dart';
import 'package:nolatech_tenis/core/di/service_locator.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('courtsBox');
  await Hive.openBox('reservationsBox');
  await di.init();
  runApp(const App());
}
