import 'package:get/get.dart';
import 'package:posapp/feature/posapp/domain/entities/product_entity.dart';
import 'package:posapp/feature/posapp/domain/entities/transaction_entity.dart';
import 'package:posapp/feature/posapp/domain/entities/transaction_item_entity.dart';
import 'package:posapp/feature/posapp/domain/usecases/product_usecase.dart';
import 'package:posapp/feature/posapp/domain/usecases/transaction_usecase.dart';

import '../../../../../../core/data/menu_type_enum.dart';

class HomeController extends GetxController {
  var isExpandedFab = false.obs;
  var listType = MenuType.PRODUCTS.obs;
  var products = <ProductEntity>[].obs;
  var transactions = <TransactionEntity>[].obs;

  final GetProductUsecase getProductUsecase;
  final GetTransactionUseCase getTransactionUsecase;
  final InsertProductUsecase insertProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final DeleteTransactionUseCase deleteTransactionUsecase;

  HomeController({
    required this.getProductUsecase,
    required this.getTransactionUsecase,
    required this.insertProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
    required this.deleteTransactionUsecase,
  });
  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadTransactions();
  }

  changeListType(MenuType type) {
    listType.value = type;
    loadProducts();
    loadTransactions();
    Get.log(
      'List type changed to: $type , products: ${products.length} , transactions: ${transactions.length}',
    );
  }

  void loadProducts() async {
    final result = await getProductUsecase.call();
    if (result.isNotEmpty) {
      products.assignAll(result);
    } else {
      products.clear();
    }
  }

  void loadTransactions() async {
    final result = await getTransactionUsecase.call();
    if (result.isNotEmpty) {
      transactions.assignAll(result);
    } else {
      transactions.clear();
    }
  }

  void updateProduct(ProductEntity p) async {
    await updateProductUsecase.call(p);
    loadProducts();
  }

  void addProduct(ProductEntity p) async {
    await insertProductUsecase.call(p);
    loadProducts();
  }

  void deleteProduct(ProductEntity elementAt) async {
    await deleteProductUsecase.call(elementAt.id);
    loadProducts();
  }

  void deleteTransaction(TransactionEntity elementAt) async {
    await deleteTransactionUsecase.call(elementAt.id);
    loadTransactions();
  }
}
