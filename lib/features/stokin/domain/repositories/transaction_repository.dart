import 'package:dartz/dartz.dart';
import 'package:stokin_bloc/cores/failures/failures.dart';

import '../../../../cores/data/transaction_type_enum.dart';
import '../entities/transaction_entity.dart';

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
