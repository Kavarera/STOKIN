import 'package:posapp/feature/posapp/data/models/product_model.dart';
import 'package:posapp/feature/posapp/domain/entities/transaction_item_entity.dart';

class TransactionItemModel extends TransactionItemEntity {
  TransactionItemModel({required super.product, required super.quantity});

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) {
    return TransactionItemModel(
      product: ProductModel.fromJson(json['product']).toEntity(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': ProductModel.fromEntity(product).toJson(),
      'quantity': quantity,
    };
  }

  TransactionItemEntity toEntity() {
    return TransactionItemEntity(product: product, quantity: quantity);
  }

  factory TransactionItemModel.fromEntity(TransactionItemEntity entity) {
    return TransactionItemModel(
      product: ProductModel.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }
}
