class ProductEntity {
  final int id;
  final String name;
  final double price;

  ProductEntity({required this.id, required this.name, required this.price});

  ProductEntity copyWith({int? id, String? name, double? price, String? unit}) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
