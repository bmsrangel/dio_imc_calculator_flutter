import 'package:flutter/material.dart';

class DecimalTextFormField extends TextFormField {
  DecimalTextFormField({
    super.key,
    String? labelText,
    super.controller,
    super.validator,
    super.textInputAction = TextInputAction.done,
  }) : super(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
}
