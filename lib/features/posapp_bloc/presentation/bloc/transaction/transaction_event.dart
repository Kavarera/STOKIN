part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class TransactionEventLoadProductsEvent extends TransactionEvent {
  const TransactionEventLoadProductsEvent();
}

class TransactionEventInitTransactionEvent extends TransactionEvent {
  final TransactionEntity? transaction;
  const TransactionEventInitTransactionEvent({this.transaction});
  @override
  List<Object?> get props => [transaction];
}

class TransactionEventProductQuantityIncreaseEvent extends TransactionEvent {
  final ProductEntity product;
  const TransactionEventProductQuantityIncreaseEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class TransactionEventProductQuantityDecreaseEvent extends TransactionEvent {
  final ProductEntity product;
  const TransactionEventProductQuantityDecreaseEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class TransactionEventUpdateTransactionEvent extends TransactionEvent {
  const TransactionEventUpdateTransactionEvent();
  @override
  List<Object?> get props => [];
}
