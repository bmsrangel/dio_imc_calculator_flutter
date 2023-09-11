import '../../models/bmi_model.dart';

abstract interface class BmiRespository {
  Future<List<BmiModel>> findAll();
  Future<void> insertOne(BmiModel bmiModel);
  Future<void> removeOne(BmiModel bmiModel);
}
