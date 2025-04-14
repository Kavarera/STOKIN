part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final List<ProductEntity> products;
  final List<TransactionItemEntity> cartItems;
  final TransactionEntity? transaction;
  TransactionState({
    required this.products,
    required this.cartItems,
    this.transaction,
  });

  @override
  List<Object?> get props => [products, cartItems, transaction];

  double get totalPrice => cartItems.fold(
    0,
    (sum, item) => sum + item.product.price * item.quantity,
  );
  bool get isUpdate => transaction != null;
  TransactionState copyWith({
    List<ProductEntity>? products,
    List<TransactionItemEntity>? cartItems,
    TransactionEntity? transaction,
  }) {
    return TransactionState(
      products: products ?? this.products,
      cartItems: cartItems ?? this.cartItems,
      transaction: transaction ?? this.transaction,
    );
  }
}
