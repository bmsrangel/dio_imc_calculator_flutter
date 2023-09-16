import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:imc_calculator_flutter/src/core/configuration/service_location_configuration.dart';

import 'src/app_widget.dart';

void main() async {
  serviceLocationConfiguration();
  await GetIt.I.isReady<Box>();
  runApp(const AppWidget());
}
