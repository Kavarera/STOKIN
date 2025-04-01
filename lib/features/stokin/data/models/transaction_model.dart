import 'package:stokin/features/stokin/data/models/category_model.dart';
import 'package:stokin/features/stokin/data/models/product_model.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';

import '../../../../core/data/transaction_type_enum.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.amount,
    required super.date,
    required super.type,
    required super.product,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type:
          json['type'] == "KELUAR"
              ? TransactionType.KELUAR
              : TransactionType.MASUK,
      product: ProductModel(
        id: json['productId'],
        name: json['product_name'],
        quantity: json['product_quantity'],
        unit: json['product_unit'],
        category:
            json['category_id'] != null
                ? CategoryModel(
                  name: json['category_name'],
                  id: json['category_id'],
                )
                : null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
      'productId': product.id,
    };
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      amount: amount,
      date: date,
      type: type,
      product: product,
    );
  }
}
