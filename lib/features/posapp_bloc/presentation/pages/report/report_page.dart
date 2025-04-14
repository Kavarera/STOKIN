import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/widgets/alert_dialog_pick_month.dart';

import '../../../../../core/configs/custom_theme.dart';
import '../../bloc/report/report_bloc.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'POSAPP',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (dialogContext) => BlocProvider.value(
                              value: context.read<ReportBloc>(),
                              child: const AlertDialogPickMonth(),
                            ),
                      );
                    },
                    style: ButtonStyle().copyWith(
                      backgroundColor:
                          state.filterDate != null
                              ? WidgetStateProperty.all(
                                CustomTheme.secondaryColor,
                              )
                              : WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text('By Month'),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  if (state.transactions.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            state.transactions[index].date.toIso8601String(),
                          ),
                          subtitle: Text(
                            'Price: ${state.transactions[index].totalAmount}',
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No transactions found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
