import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/transaction_usecase.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetTransactionUseCase getTransactionUseCase;

  ReportBloc({required this.getTransactionUseCase})
    : super(ReportState(transactions: <TransactionEntity>[])) {
    on<ReportEventLoadTransactions>(_onLoadTransactions);
    add(ReportEventLoadTransactions());
  }

  FutureOr<void> _onLoadTransactions(
    ReportEventLoadTransactions event,
    Emitter<ReportState> emit,
  ) async {
    final transactions = await getTransactionUseCase.call();
    log('transaction length : ${transactions.length}', name: 'ReportBloc');
    if (transactions.isNotEmpty) {
      var filteredTransactions = transactions;
      if (event.selectedDate != null) {
        filteredTransactions =
            transactions.where((t) {
              return t.date.year == event.selectedDate!.year &&
                  t.date.month == event.selectedDate!.month;
            }).toList();
        emit(
          ReportState(
            transactions: filteredTransactions,
            filterDate: event.selectedDate,
          ),
        );
      } else {
        emit(ReportState(transactions: transactions, filterDate: null));
      }
    } else {
      emit(ReportState(transactions: [], filterDate: event.selectedDate));
    }
  }
}
