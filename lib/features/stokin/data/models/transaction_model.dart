import 'package:stokin/features/stokin/data/models/product_model.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.date,
    required super.type,
    required super.product,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type: json['type'],
      product: ProductModel(
        id: json['productId'],
        name: json['product_name'],
        quantity: json['product_quantity'],
        unit: json['product_unit'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'productId': product.id,
      'product_name': product.name,
      'product_quantity': product.quantity,
      'product_unit': product.unit,
    };
  }
}
