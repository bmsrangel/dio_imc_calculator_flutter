import 'package:flutter/material.dart';

import '../../../core/models/bmi_model.dart';
import '../../../core/utils/date_formatter_util.dart';
import '../../../core/utils/decimal_formatter_util.dart';

class BmiListWidget extends StatelessWidget {
  const BmiListWidget({
    super.key,
    required this.bmiList,
    required this.onDismissed,
  });

  final List<BmiModel> bmiList;
  final void Function(BmiModel value) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bmiList.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final bmiModel = bmiList[index];
        return Dismissible(
          key: ValueKey(bmiModel),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            padding: const EdgeInsets.only(right: 16.0),
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (_) {
            onDismissed(bmiModel);
          },
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormatterUtil.ddMMyyyy(bmiModel.date)),
              ],
            ),
            title: Text(
              '${DecimalFormatterUtil.format(bmiModel.bmi, decimalDigits: 2)} - ${bmiModel.classification.description}',
            ),
            subtitle: Text(
              'Peso: ${DecimalFormatterUtil.format(bmiModel.weight)}kg / Altura: ${DecimalFormatterUtil.format(bmiModel.height, decimalDigits: 2)}m',
            ),
          ),
        );
      },
    );
  }
}
