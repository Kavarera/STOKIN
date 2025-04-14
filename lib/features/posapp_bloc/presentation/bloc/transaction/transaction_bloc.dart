import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/product_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/transaction_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/transaction_item_entity.dart';

import '../../../domain/usecases/product_usecase.dart';
import '../../../domain/usecases/transaction_usecase.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetProductUsecase getProductUsecase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final InsertTransactionUseCase insertTransactionUseCase;
  TransactionBloc(
    this.getProductUsecase,
    this.updateTransactionUseCase,
    this.insertTransactionUseCase,
  ) : super(TransactionState(products: [], cartItems: [])) {
    on<TransactionEventLoadProductsEvent>(_onLoadProducts);
    on<TransactionEventInitTransactionEvent>(_onInitTransaction);
    on<TransactionEventProductQuantityIncreaseEvent>(
      _onProductQuantityIncrease,
    );
    on<TransactionEventProductQuantityDecreaseEvent>(
      _onProductQuantityDecrease,
    );
    on<TransactionEventUpdateTransactionEvent>(_onUpdateTransaction);
    add(const TransactionEventInitTransactionEvent());
  }

  void _onLoadProducts(
    TransactionEventLoadProductsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final products = await getProductUsecase.call();
    emit(state.copyWith(products: products));
  }

  FutureOr<void> _onInitTransaction(
    TransactionEventInitTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final produk = await getProductUsecase.call();
    final items = event.transaction?.items ?? [];
    emit(
      state.copyWith(
        products: produk,
        cartItems: List.from(items),
        transaction: event.transaction,
      ),
    );
  }

  FutureOr<void> _onProductQuantityIncrease(
    TransactionEventProductQuantityIncreaseEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final index = state.cartItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );
    state.cartItems.forEach(
      (i) => log(i.product.name, name: 'TransactionBloc'),
    );
    final updatedCart = List<TransactionItemEntity>.from(state.cartItems);
    if (index != -1) {
      log('increase clicked', name: 'TransactionBloc');
      final item = updatedCart[index];
      updatedCart[index] = item.copyWith(quantity: item.quantity + 1);
    } else {
      log('increase clicked else', name: 'TransactionBloc');
      updatedCart.add(
        TransactionItemEntity(product: event.product, quantity: 1),
      );
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  FutureOr<void> _onProductQuantityDecrease(
    TransactionEventProductQuantityDecreaseEvent event,
    Emitter<TransactionState> emit,
  ) async {
    log('decrease clicked', name: 'TransactionBloc');
    final index = state.cartItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );
    if (index != -1) {
      final updatedCart = List<TransactionItemEntity>.from(state.cartItems);
      final current = updatedCart[index];
      if (current.quantity > 1) {
        updatedCart[index] = current.copyWith(quantity: current.quantity - 1);
      } else {
        updatedCart.removeAt(index);
        ;
      }
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  FutureOr<void> _onUpdateTransaction(
    TransactionEventUpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    if (state.transaction != null) {
      await updateTransactionUseCase.call(
        state.transaction!.copyWith(
          id: state.transaction!.id,
          items: state.cartItems,
        ),
      );
    } else {
      await insertTransactionUseCase.call(
        TransactionEntity(id: 0, date: DateTime.now(), items: state.cartItems),
      );
    }
    emit(state.copyWith(cartItems: []));
  }
}
