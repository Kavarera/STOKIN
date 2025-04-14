import 'dart:developer';

import '../entities/transaction_entity.dart';

import '../repositories/transaction_repository.dart';

class InsertTransactionUseCase {
  final TransactionRepository transactionRepository;

  InsertTransactionUseCase(this.transactionRepository);

  Future<void> call(TransactionEntity transaction) async {
    try {
      await transactionRepository.addTransaction(transaction);
      log("Berhasil add transaksi");
    } catch (e) {
      log(e.toString(), name: 'InsertTransactionUseCase');
    }
  }
}

class GetTransactionUseCase {
  final TransactionRepository transactionRepository;

  GetTransactionUseCase(this.transactionRepository);

  Future<List<TransactionEntity>> call() async {
    var data = await transactionRepository.getTransactions();
    return data.fold((l) {
      log(l.toString(), name: 'GetTransactionUseCase');
      return [];
    }, (r) => r);
  }
}

class UpdateTransactionUseCase {
  final TransactionRepository transactionRepository;

  UpdateTransactionUseCase(this.transactionRepository);

  Future<void> call(TransactionEntity transaction) async {
    try {
      await transactionRepository.updateTransaction(transaction);
      log("Berhasil update transaksi");
    } catch (e) {
      log(e.toString(), name: 'UpdateTransactionUseCase');
    }
  }
}

class DeleteTransactionUseCase {
  final TransactionRepository transactionRepository;

  DeleteTransactionUseCase(this.transactionRepository);

  Future<void> call(int transactionId) async {
    try {
      await transactionRepository.deleteTransaction(transactionId);
    } catch (e) {
      log(e.toString(), name: 'DeleteTransactionUseCase');
    }
  }
}
