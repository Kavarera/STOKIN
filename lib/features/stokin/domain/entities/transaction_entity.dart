import '../../../../cores/data/transaction_type_enum.dart';
import 'product_entity.dart';

class TransactionEntity {
  final int id;
  final int amount;
  final DateTime date;
  final TransactionType type;
  final ProductEntity product;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.product,
  });
}
