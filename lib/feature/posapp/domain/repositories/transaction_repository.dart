import 'package:dartz/dartz.dart';

import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Exception, List<TransactionEntity>>> getTransactions();
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(int transactionId);
}
