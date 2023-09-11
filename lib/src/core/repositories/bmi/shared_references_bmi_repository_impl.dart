import 'package:shared_preferences/shared_preferences.dart';

import '../../models/bmi_model.dart';
import 'bmi_respository.dart';

class SharedReferencesBmiRepositoryImpl implements BmiRespository {
  SharedReferencesBmiRepositoryImpl(this._prefs);

  final Future<SharedPreferences> _prefs;
  final String _bmiListKey = 'bmi_list';

  @override
  Future<List<BmiModel>> findAll() async {
    final prefs = await _prefs;
    final results = prefs.getStringList(_bmiListKey);
    if (results == null) {
      return [];
    } else {
      final bmiList = results.map(BmiModel.fromJson).toList();
      bmiList.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      return bmiList;
    }
  }

  @override
  Future<void> insertOne(BmiModel bmiModel) async {
    final bmiList = await findAll();
    bmiList.add(bmiModel);
    final bmiStringList = bmiList.map((bmiModel) => bmiModel.toJson()).toList();
    final prefs = await _prefs;
    await prefs.setStringList(_bmiListKey, bmiStringList);
  }

  @override
  Future<void> removeOne(BmiModel bmiModel) async {
    final bmiList = await findAll();
    bmiList.remove(bmiModel);
    final bmiStringList = bmiList.map((bmiModel) => bmiModel.toJson()).toList();
    final prefs = await _prefs;
    await prefs.setStringList(_bmiListKey, bmiStringList);
  }
}
