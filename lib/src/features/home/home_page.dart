import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/dtos/new_bmi_dto.dart';
import '../../core/repositories/bmi/bmi_respository.dart';
import '../../core/repositories/bmi/shared_references_bmi_repository_impl.dart';
import 'bmi_store.dart';
import 'widgets/bmi_list_widget.dart';
import 'widgets/new_bmi_record_alert_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final BmiRespository _bmiRespository;
  late final BmiStore _bmiStore;

  late final TextEditingController _weight$;
  late final TextEditingController _height$;

  @override
  void initState() {
    super.initState();
    final sharedPreferences = SharedPreferences.getInstance();
    _bmiRespository = SharedReferencesBmiRepositoryImpl(sharedPreferences);
    _bmiStore = BmiStore(_bmiRespository);
    _bmiStore.fetchBmiList();
  }

  @override
  void dispose() {
    _weight$.dispose();
    _height$.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Center(
        child: ListenableBuilder(
          listenable: _bmiStore,
          builder: (_, __) {
            if (_bmiStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (_bmiStore.bmiList.isEmpty) {
              return const Text('Nenhuma medição registrada');
            } else {
              return BmiListWidget(
                bmiList: _bmiStore.bmiList,
                onDismissed: (value) async {
                  await _bmiStore.removeBmi(value);
                  await _bmiStore.fetchBmiList();
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBmi = await showDialog<NewBmiDto?>(
            context: context,
            builder: (context) => const NewBmiRecordAlertWidget(),
          );
          if (newBmi != null) {
            await _bmiStore.createBmi(newBmi);
            await _bmiStore.fetchBmiList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
