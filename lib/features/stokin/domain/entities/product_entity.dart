import 'package:stokin/features/stokin/domain/entities/category_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final int quantity;
  final String unit;
  final CategoryEntity? category;

  ProductEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
  });
}
