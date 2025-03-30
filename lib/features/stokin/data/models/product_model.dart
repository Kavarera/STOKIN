import 'package:stokin/features/stokin/domain/entities/product_entity.dart';

import 'category_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.unit,
    super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
      category:
          json['category'] != null
              ? CategoryModel.fromJson(json['category'])
              : null,
    );
  }
}
