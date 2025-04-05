import 'package:dartz/dartz.dart';
import 'package:stokin_bloc/cores/failures/failures.dart';

import '../../../../cores/data/transaction_type_enum.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class InsertTransactionUseCase {
  final TransactionRepository transactionRepository;

  InsertTransactionUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, void>> call(
    TransactionEntity transaction,
  ) async {
    return await transactionRepository.insertTransaction(transaction);
  }
}

class DeleteTransactionUseCase {
  final TransactionRepository transactionRepository;

  DeleteTransactionUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, void>> call(int id) async {
    return await transactionRepository.deleteTransaction(id);
  }
}

class UpdateTransactionUseCase {
  final TransactionRepository transactionRepository;

  UpdateTransactionUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, void>> call(
    TransactionEntity transaction,
  ) async {
    return await transactionRepository.updateTransaction(transaction);
  }
}

class GetTransactionsUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionsUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, List<TransactionEntity>>> call() async {
    return await transactionRepository.getTransactions();
  }
}

class GetTransactionsByDateUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionsByDateUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, List<TransactionEntity>>> call(
    String date,
  ) async {
    return await transactionRepository.getTransactionsByDate(date);
  }
}

class GetTransactionsByCategoryUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionsByCategoryUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, List<TransactionEntity>>> call(
    int categoryId,
  ) async {
    return await transactionRepository.getTransactionsByCategory(categoryId);
  }
}

class GetTransactionsByProductUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionsByProductUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, List<TransactionEntity>>> call(
    int productId,
  ) async {
    return await transactionRepository.getTransactionsByProduct(productId);
  }
}

class GetTransactionsByTypeUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionsByTypeUseCase(this.transactionRepository);

  Future<Either<DatabaseFailure, List<TransactionEntity>>> call(
    TransactionType type,
  ) async {
    return await transactionRepository.getTransactionsByType(type);
  }
}
