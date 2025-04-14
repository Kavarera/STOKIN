import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({required super.id, required super.name, required super.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price};
  }

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, price: price);
  }

  factory ProductModel.fromEntity(ProductEntity product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
    );
  }
}
