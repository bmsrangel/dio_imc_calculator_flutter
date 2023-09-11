import 'dart:math';

import '../enums/imc_classification_enum.dart';

class BmiCalculator {
  static double calculateBmi(double weight, double height) {
    final bmi = weight / pow(height, 2);
    return double.parse(bmi.toStringAsFixed(2));
  }

  static BMIClassificationEnum getBMIClassification(double bmi) {
    switch (bmi) {
      case < 16:
        return BMIClassificationEnum.severeThinness;
      case < 17:
        return BMIClassificationEnum.moderateThinness;
      case < 18.5:
        return BMIClassificationEnum.mildThinness;
      case < 25:
        return BMIClassificationEnum.normal;
      case < 30:
        return BMIClassificationEnum.overweight;
      case < 35:
        return BMIClassificationEnum.obesityI;
      case < 40:
        return BMIClassificationEnum.obesityII;
      default:
        return BMIClassificationEnum.obesityIII;
    }
  }
}
