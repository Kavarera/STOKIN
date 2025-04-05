import 'category_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final int quantity;
  final String unit;
  CategoryEntity? category;

  ProductEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
  });

  ProductEntity copyWith({
    int? id,
    String? name,
    int? quantity,
    String? unit,
    CategoryEntity? category,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
    );
  }
}
