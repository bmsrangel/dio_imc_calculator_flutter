import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app_widget.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const AppWidget());
}
