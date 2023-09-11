import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../enums/imc_classification_enum.dart';

class BmiModel extends Equatable {
  const BmiModel({
    required this.weight,
    required this.height,
    required this.bmi,
    required this.classification,
    required this.date,
  });

  final double weight;
  final double height;
  final double bmi;
  final BMIClassificationEnum classification;
  final DateTime date;

  @override
  List<Object?> get props => [weight, height, bmi, classification, date];

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'classification': classification.index,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory BmiModel.fromMap(Map<String, dynamic> map) {
    return BmiModel(
      weight: map['weight']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      bmi: map['bmi']?.toDouble() ?? 0.0,
      classification:
          BMIClassificationEnum.values[map['classification'] as int],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BmiModel.fromJson(String source) =>
      BmiModel.fromMap(json.decode(source));
}
