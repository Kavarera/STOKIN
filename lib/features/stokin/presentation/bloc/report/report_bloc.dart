import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stokin_bloc/features/stokin/domain/usecases/product_usecase.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/category_usecase.dart';
import '../../../domain/usecases/transaction_usecase.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  ReportBloc(
    super.initialState, {
    required this.getCategoriesUseCase,
    required this.getTransactionsUseCase,
  }) {
    on<ReportEventLoadItems>(_onLoadItems);
    on<ReportEventCategoryFilter>(_onCategoryFilter);
    on<ReportEventMonthFilter>(_onMonthFilter);
    on<ReportEventProductFilter>(_onProductFilter);
    on<ReportEventClearFilter>(_onClearFilter);
  }

  FutureOr<void> _onLoadItems(
    ReportEventLoadItems event,
    Emitter<ReportState> emit,
  ) async {
    final cResult = await getCategoriesUseCase.call();
    final tResult = await getTransactionsUseCase.call();

    final List<CategoryEntity> categories = cResult.fold(
      (failure) => [],
      (data) => data,
    );
    final List<TransactionEntity> transactions = tResult.fold(
      (failure) => [],
      (data) => data,
    );
    final List<ProductEntity> products =
        transactions.map((t) => t.product).toSet().toList();

    emit(
      state.copyWith(
        categories: categories,
        transactions: transactions,
        products: products,
      ),
    );
  }

  FutureOr<void> _onCategoryFilter(
    ReportEventCategoryFilter event,
    Emitter<ReportState> emit,
  ) async {
    final newState = state.copyWith(selectedCategoryId: event.categoryId);
    await _applyFilter(emit, newState);
  }

  FutureOr<void> _onMonthFilter(
    ReportEventMonthFilter event,
    Emitter<ReportState> emit,
  ) async {
    final newState = state.copyWith(selectedMonth: event.month);
    await _applyFilter(emit, newState);
  }

  FutureOr<void> _onProductFilter(
    ReportEventProductFilter event,
    Emitter<ReportState> emit,
  ) async {
    final newState = state.copyWith(selectedProductId: event.productId);
    await _applyFilter(emit, newState);
  }

  FutureOr<void> _onClearFilter(
    ReportEventClearFilter event,
    Emitter<ReportState> emit,
  ) async {
    final newState = state.copyWith(
      selectedCategoryId: 0,
      selectedMonth: null as DateTime?,
      selectedProductId: 0,
    );

    log(
      'CLEAR FILTER APPLIED: ${newState.selectedMonth?.toString() ?? 'N/A'}',
      name: 'ReportBloc',
    );
    log('CLEAR FILTER', name: 'ReportBloc');
    await _applyFilter(emit, newState);
  }

  Future<void> _applyFilter(
    Emitter<ReportState> emit,
    ReportState newState,
  ) async {
    final result = await getTransactionsUseCase.call();
    log('getTransactionsUseCase called', name: 'ReportBloc');
    List<TransactionEntity> data = result.fold((l) => [], (r) => r);
    log('transactions loaded: ${data.length}', name: 'ReportBloc');
    if (newState.selectedCategoryId != 0) {
      log('category Filter applied', name: 'ReportBloc');
      data =
          data.where((transaction) {
            return transaction.product.category?.id ==
                newState.selectedCategoryId;
          }).toList();
    }

    if (newState.selectedMonth != null) {
      log('month Filter applied', name: 'ReportBloc');
      data =
          data
              .where(
                (t) =>
                    t.date.month == newState.selectedMonth!.month &&
                    t.date.year == newState.selectedMonth!.year,
              )
              .toList();
    }

    if (newState.selectedProductId != 0) {
      log('product Filter applied', name: 'ReportBloc');
      data =
          data.where((transaction) {
            return transaction.product.id == newState.selectedProductId;
          }).toList();
    }

    emit(
      newState.copyWith(
        selectedCategoryId: newState.selectedCategoryId,
        selectedMonth: newState.selectedMonth,
        selectedProductId: newState.selectedProductId,
        transactions: data,
      ),
    );

    log('transactions filtered: ${data.length}', name: 'ReportBloc');
  }
}
