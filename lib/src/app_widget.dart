import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC Flutter',
      home: HomePage(
        bmiStore: GetIt.I.get(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF552176),
        ),
      ),
    );
  }
}
