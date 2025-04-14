import '../../domain/entities/transaction_entity.dart';
import 'transaction_item_model.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.date,
    required super.items,
  });

  factory TransactionModel.fromEntity(TransactionEntity transaction) {
    return TransactionModel(
      id: transaction.id,
      date: transaction.date,
      items: transaction.items,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(id: id, date: date, items: items);
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      items:
          (json['items'] as List)
              .map((e) => TransactionItemModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      // 'items':
      //     items
      //         .map((e) => TransactionItemModel.fromEntity(e).toJson())
      //         .toList(),
    };
  }
}
