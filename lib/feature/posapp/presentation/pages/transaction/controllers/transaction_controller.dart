import 'package:get/get.dart';
import 'package:posapp/feature/posapp/domain/entities/transaction_entity.dart';
import 'package:posapp/feature/posapp/domain/usecases/product_usecase.dart';
import 'package:posapp/feature/posapp/domain/usecases/transaction_usecase.dart';

import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/entities/transaction_item_entity.dart';

class TransactionController extends GetxController {
  var products = <ProductEntity>[].obs;
  TransactionEntity? transaction;
  bool get isUpdate => transaction != null;
  var cartTransactions = <TransactionItemEntity>[].obs;
  final GetProductUsecase getProductUsecase;
  final InsertTransactionUseCase insertTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;

  TransactionController({
    required this.getProductUsecase,
    required this.insertTransactionUseCase,
    required this.updateTransactionUseCase,
  });

  @override
  void onInit() {
    transaction = Get.arguments as TransactionEntity?;
    super.onInit();
    if (transaction != null) {
      cartTransactions.assignAll(transaction!.items);
    }
    loadProducts();
  }

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }

  void addProductToCart(ProductEntity product) {
    final index = cartTransactions.indexWhere(
      (e) => e.product.id == product.id,
    );
    if (index != -1) {
      cartTransactions[index] = cartTransactions[index].copyWith(
        quantity: cartTransactions[index].quantity + 1,
      );
    } else {
      cartTransactions.add(
        TransactionItemEntity(product: product, quantity: 1),
      );
    }
  }

  void removeProductFromCart(ProductEntity product) {
    final index = cartTransactions.indexWhere(
      (e) => e.product.id == product.id,
    );
    if (index != -1) {
      final current = cartTransactions[index];
      if (current.quantity > 1) {
        cartTransactions[index] = current.copyWith(
          quantity: current.quantity - 1,
        );
      } else {
        cartTransactions.removeAt(index);
      }
    }
  }

  int getQuantity(ProductEntity product) {
    return cartTransactions
            .firstWhereOrNull((e) => e.product.id == product.id)
            ?.quantity ??
        0;
  }

  double getTotalPriceCart() {
    double total = 0;
    for (var item in cartTransactions) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  void loadProducts() async {
    final result = await getProductUsecase.call();
    products.assignAll(result);
  }

  void updateTransaction(TransactionEntity transactionEntity) {}

  void insertTransaction() async {
    final transaction = TransactionEntity(
      id: 0,
      date: DateTime.now(),
      items: cartTransactions,
    );
    await insertTransactionUseCase.call(transaction);
    cartTransactions.clear();
  }
}
