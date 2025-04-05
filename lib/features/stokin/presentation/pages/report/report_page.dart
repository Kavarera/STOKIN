import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/report/report_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/widgets/alert_dialog_pick_category.dart';
import 'package:stokin_bloc/features/stokin/presentation/widgets/alert_dialog_pick_month.dart';
import '../../../../../cores/data/transaction_type_enum.dart';
import '../../widgets/alert_dialog_pick_product.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReportBloc>().add(const ReportEventLoadItems());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'STOKIN',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<ReportBloc, ReportState>(
          buildWhen: (previous, current) {
            return true; // pastikan tetap true
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed:
                          () => context.read<ReportBloc>().add(
                            const ReportEventClearFilter(),
                          ),
                      child: const Text('All'),
                    ),
                    TextButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialogPickCategory(
                                  categories: state.categories,
                                  selectedCategoryId: state.selectedCategoryId,
                                  onPick:
                                      (id) => context.read<ReportBloc>().add(
                                        ReportEventCategoryFilter(id),
                                      ),
                                ),
                          ),
                      style: ButtonStyle().copyWith(
                        backgroundColor:
                            state.selectedCategoryId != 0
                                ? WidgetStateProperty.all(Colors.blue)
                                : WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: const Text('By Category'),
                    ),
                    TextButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialogPickMonth(
                                  onPick: (date) {
                                    context.read<ReportBloc>().add(
                                      ReportEventMonthFilter(date),
                                    );
                                  },
                                  selectedMonth: state.selectedMonth,
                                ),
                          ),
                      style: ButtonStyle().copyWith(
                        backgroundColor:
                            state.selectedMonth != null
                                ? WidgetStateProperty.all(Colors.blue)
                                : WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: const Text('By Month'),
                    ),
                    TextButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialogPickProduct(
                                  products: state.products,
                                  selectedProductId: state.selectedProductId,
                                  onPick:
                                      (id) => context.read<ReportBloc>().add(
                                        ReportEventProductFilter(id),
                                      ),
                                ),
                          ),
                      style: ButtonStyle().copyWith(
                        backgroundColor:
                            state.selectedProductId != 0
                                ? WidgetStateProperty.all(Colors.blue)
                                : WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: const Text('By Product'),
                    ),
                  ],
                ),
                Expanded(
                  child:
                      state.transactions.isEmpty
                          ? const Center(child: Text('No transactions found'))
                          : ListView.builder(
                            itemCount: state.transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = state.transactions[index];
                              return ListTile(
                                title: Text(transaction.product.name),
                                subtitle: Text(
                                  DateFormat(
                                    'dd MMMM yyyy',
                                  ).format(transaction.date),
                                ),
                                trailing: Text(
                                  "${transaction.type == TransactionType.MASUK ? '+' : '-'}${transaction.amount.toString()}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
