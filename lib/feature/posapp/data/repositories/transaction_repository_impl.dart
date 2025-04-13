import 'package:dartz/dartz.dart';
import 'package:posapp/feature/posapp/data/datasources/posapp_local_datasource.dart';
import 'package:posapp/feature/posapp/data/models/transaction_model.dart';
import 'package:posapp/feature/posapp/domain/entities/transaction_entity.dart';
import 'package:posapp/feature/posapp/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final PosappLocalDatasource _localDatasource;
  TransactionRepositoryImpl(this._localDatasource);
  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    try {
      await _localDatasource.insertTransaction(
        TransactionModel.fromEntity(transaction),
      );
    } catch (e) {
      throw Exception('Error adding transaction: $e');
    }
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _localDatasource.deleteTransaction(transactionId);
    } catch (e) {
      throw Exception('Error deleting transaction: $e');
    }
  }

  @override
  Future<Either<Exception, List<TransactionEntity>>> getTransactions() async {
    try {
      final transactions = await _localDatasource.getTransactions();
      return Right(transactions.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Exception('Error fetching transactions: $e'));
    }
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    try {
      await _localDatasource.updateTransaction(
        TransactionModel.fromEntity(transaction),
      );
    } catch (e) {
      throw Exception('Error updating transaction: $e');
    }
  }
}
