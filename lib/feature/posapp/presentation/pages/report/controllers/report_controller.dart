import 'package:get/get.dart';
import 'package:posapp/feature/posapp/domain/usecases/transaction_usecase.dart';

import '../../../../domain/entities/transaction_entity.dart';

class ReportController extends GetxController {
  final GetTransactionUseCase getTransactionUseCase;
  ReportController({required this.getTransactionUseCase});

  var selectedDate = Rxn<DateTime?>();

  var transactions = <TransactionEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  void loadTransactions() async {
    final result = await getTransactionUseCase.call();
    if (result.isNotEmpty) {
      var filteredTransactions = result;
      if (selectedDate.value != null) {
        filteredTransactions =
            filteredTransactions.where((transaction) {
              return transaction.date.year == selectedDate.value!.year &&
                  transaction.date.month == selectedDate.value!.month;
            }).toList();
      }
      transactions.assignAll(filteredTransactions);
    } else {
      transactions.clear();
    }
  }

  void updateDate(DateTime? data) {
    selectedDate.value = data;
    loadTransactions();
  }
}
