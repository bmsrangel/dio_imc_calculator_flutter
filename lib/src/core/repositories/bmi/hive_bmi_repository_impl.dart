import 'package:hive/hive.dart';
import 'package:imc_calculator_flutter/src/core/models/bmi_model.dart';
import 'package:imc_calculator_flutter/src/core/repositories/bmi/bmi_respository.dart';

class HiveBmiRepositoryImpl implements BmiRespository {
  HiveBmiRepositoryImpl(this._box) {
    _boxKey = 'bmi_list';
  }

  final Future<Box> _box;
  late final String _boxKey;

  @override
  Future<List<BmiModel>> findAll() async {
    final box = await _box;
    final results = box.get(_boxKey, defaultValue: <Map<String, dynamic>>[]);
    final bmiMapList =
        (results as List).map((e) => Map<String, dynamic>.from(e)).toList();
    return bmiMapList.map(BmiModel.fromMap).toList();
  }

  @override
  Future<void> insertOne(BmiModel bmiModel) async {
    final bmiList = await findAll();
    bmiList.add(bmiModel);
    final box = await _box;
    await box.put(_boxKey, bmiList.map((bmi) => bmi.toMap()).toList());
  }

  @override
  Future<void> removeOne(BmiModel bmiModel) async {
    final bmiList = await findAll();
    bmiList.remove(bmiModel);
    final box = await _box;
    await box.put(_boxKey, bmiList.map((bmi) => bmi.toMap()).toList());
  }
}
