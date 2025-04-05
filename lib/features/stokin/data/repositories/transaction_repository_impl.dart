import 'package:dartz/dartz.dart';

import '../../../../cores/data/transaction_type_enum.dart';
import '../../../../cores/failures/failures.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/stokin_local_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final StokinLocalDataSource localDataSource;
  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<DatabaseFailure, void>> deleteTransaction(int id) async {
    try {
      localDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactions() async {
    try {
      final transactions = await localDataSource.getTransactions();
      return Right(transactions.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByCategory(int categoryId) async {
    try {
      final transactions = await localDataSource.getTransactions();
      return Right(
        transactions
            .map((e) => e.toEntity())
            .toList()
            .where((t) => t.product.category?.id == categoryId)
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByDate(String date) async {
    try {
      final transactions = await localDataSource.getTransactions();
      return Right(
        transactions
            .map((e) => e.toEntity())
            .toList()
            .where((t) => t.date.toString().contains(date))
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByProduct(int productId) async {
    try {
      final transactions = await localDataSource.getTransactions();
      return Right(
        transactions
            .map((e) => e.toEntity())
            .toList()
            .where((t) => t.product.id == productId)
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, void>> insertTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      await localDataSource.insertTransaction(
        TransactionModel(
          id: transaction.id,
          amount: transaction.amount,
          date: transaction.date,
          type: transaction.type,
          product: transaction.product,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, void>> updateTransaction(
    TransactionEntity transaction,
  ) async {
    try {
      await localDataSource.updateTransaction(
        TransactionModel(
          id: transaction.id,
          amount: transaction.amount,
          date: transaction.date,
          type: transaction.type,
          product: transaction.product,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TransactionEntity>>>
  getTransactionsByType(TransactionType type) async {
    try {
      final transactions = await localDataSource.getTransactions();
      return Right(
        transactions
            .map((e) => e.toEntity())
            .toList()
            .where((t) => t.type == type)
            .toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
