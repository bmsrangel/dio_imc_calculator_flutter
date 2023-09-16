import 'package:flutter/material.dart';

import '../../core/dtos/new_bmi_dto.dart';
import '../../core/models/bmi_model.dart';
import '../../core/repositories/bmi/bmi_respository.dart';
import '../../core/services/bmi_calculator_service.dart';

class BmiStore extends ChangeNotifier {
  BmiStore(this._bmiRespository);

  final BmiRespository _bmiRespository;

  bool isLoading = true;
  List<BmiModel> bmiList = [];

  double? get lastHeight => bmiList.isEmpty ? null : bmiList.last.height;

  Future<void> fetchBmiList() async {
    isLoading = true;
    notifyListeners();
    bmiList = await _bmiRespository.findAll();
    isLoading = false;
    notifyListeners();
  }

  Future<void> createBmi(NewBmiDto value) async {
    final bmi = BmiCalculatorService.calculateBmi(value.weight, value.height);
    final classification = BmiCalculatorService.getBMIClassification(bmi);
    final newBmiModel = BmiModel(
      weight: value.weight,
      height: value.height,
      bmi: bmi,
      classification: classification,
      date: DateTime.now(),
    );
    await _bmiRespository.insertOne(newBmiModel);
  }

  Future<void> removeBmi(BmiModel value) async {
    await _bmiRespository.removeOne(value);
  }
}
