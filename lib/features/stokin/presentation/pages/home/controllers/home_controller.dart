import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:stokin/core/error/failure.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';
import 'package:stokin/features/stokin/domain/entities/product_entity.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';
import 'package:stokin/features/stokin/domain/usecases/category_usecases.dart';

import '../../../../../../core/data/menu_type_enum.dart';
import '../../../../../../core/data/transaction_type_enum.dart';
import '../../../../domain/usecases/product_usecases.dart';
import '../../../../domain/usecases/transaction_usecases.dart';

class HomeController extends GetxController {
  var isExpandedFab = false.obs;
  var listType = MenuType.PRODUCTS.obs;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final GetTransactionsByCategoryUseCase getTransactionByCategory;
  final GetTransactionsByDateUseCase getTransactionByDate;
  final GetTransactionsByProductUseCase getTransactionByProduct;
  final GetTransactionsByTypeUseCase getTransactionByType;
  final InsertCategoryUseCase insertCategoryUseCase;
  final InsertProductUseCase insertProductUseCase;
  final InsertTransactionUseCase insertTransactionUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  final UpdateProductUseCase updateProductUseCase;

  HomeController({
    required this.getTransactionByCategory,
    required this.getTransactionByDate,
    required this.getTransactionByProduct,
    required this.getTransactionByType,
    required this.updateProductUseCase,
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.getTransactionsUseCase,
    required this.insertCategoryUseCase,
    required this.insertProductUseCase,
    required this.insertTransactionUseCase,
    required this.deleteCategoryUseCase,
    required this.deleteProductUseCase,
    required this.deleteTransactionUseCase,
  });

  changeListType(MenuType type) {
    listType.value = type;
  }

  Future<List<ProductEntity>> getProducts() async {
    final result = await getProductsUseCase.call();
    return result.fold((l) => [], (r) => r);
  }

  Future<List<CategoryEntity>> getCategories() async {
    final result = await getCategoriesUseCase.call();
    return result.fold((l) => [], (r) => r);
  }

  Future<List<TransactionEntity>> getTransactions() async {
    Either<Failure, List<TransactionEntity>> result =
        await getTransactionsUseCase.call();
    return result.fold((l) {
      log('error: ${l.message}', name: "HOMECONTROLLER");
      return [];
    }, (r) => r);
  }

  void deleteItem(dynamic item) async {
    if (item is ProductEntity) {
      final result = await deleteProductUseCase.call(item.id);
      result.fold((l) {}, (r) {
        listType.refresh();
      });
    } else if (item is TransactionEntity) {
      ProductEntity? p = await getProductsUseCase.call().then((value) {
        return value.fold(
          (l) => null,
          (r) => r.firstWhereOrNull((e) => e.id == item.product.id)!,
        );
      });
      if (p != null) {
        if (item.type == TransactionType.KELUAR) {
          await updateProductUseCase.call(
            p.copyWith(quantity: p.quantity + item.amount),
          );
        } else {
          await updateProductUseCase.call(
            p.copyWith(quantity: p.quantity - item.amount),
          );
        }
      }

      final result = await deleteTransactionUseCase.call(item.id);
      result.fold((l) {}, (r) {
        listType.refresh();
      });
    } else if (item is CategoryEntity) {
      final result = await deleteCategoryUseCase.call(item.id!);
      result.fold((l) {}, (r) {
        listType.refresh();
      });
    }
  }

  void updateProduct(ProductEntity product) async {
    log('scategory: ${product.category?.name}', name: "HOMECONTROLLER");
    final result = await updateProductUseCase.call(product);
    result.fold((l) {}, (r) {
      listType.refresh();
    });
  }

  void addProduct(ProductEntity product) async {
    final result = await insertProductUseCase.call(product);
    result.fold((l) {}, (r) {
      listType.refresh();
    });
  }

  void addCategory(CategoryEntity category) async {
    final result = await insertCategoryUseCase.call(category);
    result.fold((l) {}, (r) {
      listType.refresh();
    });
  }

  void addTrasaction(TransactionEntity transaction) async {
    final result = await insertTransactionUseCase.call(transaction);
    log('transaction: ${transaction.product.name}', name: "HOMECONTROLLER");
    result.fold(
      (l) {
        log('error: ${l.message}', name: "HOMECONTROLLER");
      },
      (r) async {
        var ps = await getProductsUseCase.call();
        ProductEntity? p = ps.fold(
          (l) => null,
          (r) => r.firstWhereOrNull((e) => e.id == transaction.product.id),
        );
        if (p != null) {
          if (transaction.type == TransactionType.KELUAR) {
            await updateProductUseCase.call(
              p.copyWith(quantity: p.quantity - transaction.amount),
            );
          } else {
            await updateProductUseCase.call(
              p.copyWith(quantity: p.quantity + transaction.amount),
            );
          }
        }
        listType.refresh();
      },
    );
  }
}
