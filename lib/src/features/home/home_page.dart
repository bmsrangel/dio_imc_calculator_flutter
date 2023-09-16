import 'package:flutter/material.dart';

import '../../core/dtos/new_bmi_dto.dart';
import 'bmi_store.dart';
import 'widgets/bmi_list_widget.dart';
import 'widgets/new_bmi_record_alert_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required BmiStore bmiStore})
      : _bmiStore = bmiStore;

  final BmiStore _bmiStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BmiStore get _bmiStore => widget._bmiStore;

  @override
  void initState() {
    super.initState();
    _bmiStore.fetchBmiList();
  }

  @override
  void dispose() {
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
            builder: (context) => NewBmiRecordAlertWidget(
              lastHeight: _bmiStore.lastHeight,
            ),
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
