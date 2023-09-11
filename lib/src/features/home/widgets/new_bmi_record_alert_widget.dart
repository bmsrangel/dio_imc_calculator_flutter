import 'package:flutter/material.dart';

import '../../../core/dtos/new_bmi_dto.dart';
import 'decimal_text_form_field.dart';

class NewBmiRecordAlertWidget extends StatefulWidget {
  const NewBmiRecordAlertWidget({
    super.key,
  });

  @override
  State<NewBmiRecordAlertWidget> createState() =>
      _NewBmiRecordAlertWidgetState();
}

class _NewBmiRecordAlertWidgetState extends State<NewBmiRecordAlertWidget> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _weight$;
  late final TextEditingController _height$;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _weight$ = TextEditingController();
    _height$ = TextEditingController();
  }

  @override
  void dispose() {
    _weight$.dispose();
    _height$.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo Registro'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecimalTextFormField(
              labelText: 'Peso',
              controller: _weight$,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu peso';
                } else {
                  final sanitazedValue = value.replaceFirst(',', '.');
                  final weight = double.tryParse(sanitazedValue);
                  if (weight == null || weight <= 0) {
                    return 'Valor inválido';
                  } else {
                    return null;
                  }
                }
              },
            ),
            const SizedBox(height: 16.0),
            DecimalTextFormField(
              labelText: 'Altura',
              controller: _height$,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua altura';
                } else {
                  final sanitazedValue = value.replaceFirst(',', '.');
                  final height = double.tryParse(sanitazedValue);
                  if (height == null || height <= 0) {
                    return 'Valor inválido';
                  } else {
                    return null;
                  }
                }
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String weightString =
                      _weight$.text.trim().replaceFirst(',', '.');
                  final String heightString =
                      _height$.text.trim().replaceFirst(',', '.');
                  final double weight = double.parse(weightString);
                  final double height = double.parse(heightString);
                  final newBmiDto = NewBmiDto(
                    weight: weight,
                    height: height,
                  );
                  Navigator.pop(
                    context,
                    newBmiDto,
                  );
                }
              },
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
