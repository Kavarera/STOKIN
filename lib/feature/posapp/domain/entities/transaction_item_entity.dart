import 'product_entity.dart';

class TransactionItemEntity {
  final ProductEntity product;
  final int quantity;

  TransactionItemEntity({required this.product, required this.quantity});

  double get total => product.price * quantity;

  TransactionItemEntity copyWith({ProductEntity? product, int? quantity}) {
    return TransactionItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
