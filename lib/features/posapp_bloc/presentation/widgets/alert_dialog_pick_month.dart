import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/report/report_bloc.dart';

class AlertDialogPickMonth extends StatelessWidget {
  const AlertDialogPickMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a Month'),
      content: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.filterDate != null
                    ? DateFormat('MMMM yyyy').format(state.filterDate!)
                    : "No month selected",
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Select Month'),
                value: state.filterDate?.month,
                onChanged: (int? newMonth) {
                  if (newMonth != null) {
                    context.read<ReportBloc>().add(
                      ReportEventLoadTransactions(
                        selectedDate: DateTime(DateTime.now().year, newMonth),
                      ),
                    );
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
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ReportBloc>().add(ReportEventLoadTransactions());
            Navigator.pop(context);
          },
          child: Text('Clear'),
        ),
      ],
    );
  }
}
