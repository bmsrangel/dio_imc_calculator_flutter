import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_calculator_flutter/src/core/repositories/bmi/bmi_respository.dart';
import 'package:imc_calculator_flutter/src/core/repositories/bmi/hive_bmi_repository_impl.dart';
import 'package:imc_calculator_flutter/src/features/home/bmi_store.dart';

void serviceLocationConfiguration() {
  GetIt.I.registerLazySingletonAsync<Box>(() async {
    await Hive.initFlutter();
    final box = Hive.openBox('bmi');
    return box;
  });
  GetIt.I.registerSingletonWithDependencies<BmiRespository>(
    () => HiveBmiRepositoryImpl(GetIt.I.get()),
    dependsOn: [
      Box,
    ],
  );
  GetIt.I.registerSingletonWithDependencies(
    () => BmiStore(
      GetIt.I.get(),
    ),
    dependsOn: [
      BmiRespository,
    ],
  );
}
