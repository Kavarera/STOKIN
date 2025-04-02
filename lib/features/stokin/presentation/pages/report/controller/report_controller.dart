import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stokin/features/stokin/domain/usecases/category_usecases.dart';
import 'package:stokin/features/stokin/domain/usecases/transaction_usecases.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/transaction_entity.dart';

class ReportController extends GetxController {
  final GetTransactionsUseCase getTransactionsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  var selectedCategoryId = 0.obs;
  var selectedDate = Rxn<DateTime>();
  var selectedProductId = 0.obs;

  var transactions = <TransactionEntity>[].obs;
  var categories = <CategoryEntity>[].obs;
  var products = <ProductEntity>[].obs; // ✅ Add product list

  ReportController({
    required this.getCategoriesUseCase,
    required this.getTransactionsUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchTransactions();
  }

  Future<void> fetchCategories() async {
    final result = await getCategoriesUseCase.call();
    result.fold((failure) {
      categories.value = [];
    }, (data) => categories.value = data);
  }

  Future<void> fetchTransactions() async {
    final result = await getTransactionsUseCase.call();

    result.fold((failure) => transactions.value = [], (data) {
      var filteredTransactions = data;

      products.assignAll(data.map((t) => t.product).toSet().toList());

      // Filter berdasarkan kategori
      if (selectedCategoryId.value != 0) {
        filteredTransactions =
            filteredTransactions.where((transaction) {
              return transaction.product.category?.id ==
                  selectedCategoryId.value;
            }).toList();
      }

      // Filter berdasarkan bulan
      if (selectedDate.value != null) {
        filteredTransactions =
            filteredTransactions.where((transaction) {
              return DateFormat('MMM').format(transaction.date) ==
                  DateFormat('MMM').format(selectedDate.value!);
            }).toList();
      }

      // Filter berdasarkan produk
      if (selectedProductId.value != 0) {
        filteredTransactions =
            filteredTransactions.where((transaction) {
              return transaction.product.id == selectedProductId.value;
            }).toList();
      }

      transactions.assignAll(filteredTransactions);
    });
  }

  void updateCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
    fetchTransactions();
  }

  void updateDate(DateTime? data) {
    selectedDate.value = data;
    fetchTransactions();
  }

  void updateSelectedProduct(int productId) {
    selectedProductId.value = productId;
    fetchTransactions();
  }
}
