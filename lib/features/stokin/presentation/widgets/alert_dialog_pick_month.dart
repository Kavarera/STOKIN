import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertDialogPickMonth extends StatelessWidget {
  final DateTime? selectedMonth;
  final void Function(DateTime?) onPick;
  const AlertDialogPickMonth({
    super.key,
    this.selectedMonth,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a Month'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedMonth != null
                ? 'Selected: ${DateFormat('MMMM yyyy').format(selectedMonth!)}'
                : 'No month selected',
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: 'Select Month'),
            value: selectedMonth?.month,
            onChanged: (newValue) {
              if (newValue != null) {
                onPick(DateTime(DateTime.now().year, newValue));
                Navigator.of(context).pop();
              }
            },
            items: List.generate(12, (index) {
              final monthName = DateFormat(
                'MMMM',
              ).format(DateTime(2000, index + 1));
              return DropdownMenuItem<int>(
                value: index + 1,
                child: Text(monthName),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPick(null);
            Navigator.pop(context);
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }
}
