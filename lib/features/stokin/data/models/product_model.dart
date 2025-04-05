import '../../domain/entities/product_entity.dart';
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
          json['categoryId'] != null
              ? CategoryModel(
                name: json['category_name'],
                id: json['categoryId'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'categoryId': category?.id,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      quantity: quantity,
      unit: unit,
      category:
          category != null
              ? CategoryModel(id: category!.id, name: category!.name)
              : null,
    );
  }
}
