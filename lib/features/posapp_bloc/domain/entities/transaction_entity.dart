import 'transaction_item_entity.dart';

class TransactionEntity {
  final int id;
  final DateTime date;
  final List<TransactionItemEntity> items;

  TransactionEntity({
    required this.id,
    required this.date,
    required this.items,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.total);

  TransactionEntity copyWith({
    int? id,
    DateTime? date,
    List<TransactionItemEntity>? items,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }
}
