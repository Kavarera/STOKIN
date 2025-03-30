import 'package:dartz/dartz.dart';
import 'package:stokin/core/data/transaction_type_enum.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';

import '../../../../core/error/failure.dart';

abstract class TransactionRepository {
  Future<Either<DatabaseFailure, void>> insertTransaction(
    TransactionEntity transaction,
  );
  Future<Either<DatabaseFailure, void>> deleteTransaction(int id);
  Future<Either<DatabaseFailure, void>> updateTransaction(
    TransactionEntity transaction,
  );
  Future<Either<DatabaseFailure, List<TransactionEntity>>> getTransactions();
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByDate(String date);
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByCategory(int categoryId);
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByProduct(int productId);
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByType(TransactionType type);
}
