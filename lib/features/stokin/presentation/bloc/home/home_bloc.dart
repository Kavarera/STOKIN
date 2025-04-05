import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/cores/data/menu_type_enum.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/product_entity.dart';
import 'package:stokin_bloc/features/stokin/domain/usecases/category_usecase.dart';
import 'package:stokin_bloc/features/stokin/domain/usecases/product_usecase.dart';

import '../../../../../cores/data/transaction_type_enum.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/transaction_usecase.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //category Usecase
  final InsertCategoryUseCase insertCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  //product
  final InsertProductUseCase insertProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;

  //transaction
  final InsertTransactionUseCase insertTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;

  HomeBloc({
    required this.insertCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getCategoriesUseCase,
    required this.insertProductUseCase,
    required this.deleteProductUseCase,
    required this.getProductsUseCase,
    required this.updateProductUseCase,
    required this.insertTransactionUseCase,
    required this.deleteTransactionUseCase,
    required this.getTransactionsUseCase,
  }) : super(const HomeStateItemEmpty(menuType: MenuType.PRODUCTS)) {
    on<HomeEventGetItems>(_onGetItems);
    on<HomeEventChangeMenuView>(_onChangeMenuView);
    on<HomeEventAddProduct>(_onAddProduct);
    on<HomeEventUpdateProduct>(_onUpdateProduct);
    on<HomeEventDeleteProduct>(_onDeleteProduct);
    on<HomeEventAddCategory>(_onAddCategory);
    on<HomeEventDeleteCategory>(_onDeleteCategory);
    on<HomeEventAddTransaction>(_onAddTransaction);
    on<HomeEventDeleteTransaction>(_onDeleteTransaction);
    on<HomeEventLoadProductsOnly>(_onLoadProductsOnly);
  }

  FutureOr<void> _onGetItems(
    HomeEventGetItems event,
    Emitter<HomeState> emit,
  ) async {
    final menuType = state.menuType;
    emit(HomeStateLoading(menuType: menuType));
    await _loadItemsByMenu(menuType, emit);
  }

  Future<void> _loadItemsByMenu(
    MenuType currentMenu,
    Emitter<HomeState> emit,
  ) async {
    try {
      switch (currentMenu) {
        case MenuType.PRODUCTS:
          final resultProduct = await getProductsUseCase.call();
          final resultCategories = await getCategoriesUseCase.call();
          resultProduct.fold(
            (left) {
              emit(
                HomeStateError(
                  message: "${left.toString()}-${left.message}",
                  menuType: currentMenu,
                ),
              );
            },
            (right) {
              if (right.isEmpty) {
                emit(HomeStateItemEmpty(menuType: currentMenu));
              } else {
                resultCategories.fold(
                  (left) {
                    emit(
                      HomeStateError(
                        message: "${left.toString()}-${left.message}",
                        menuType: currentMenu,
                      ),
                    );
                  },
                  (rc) {
                    emit(
                      HomeStateLoadedProducts(
                        products: right,
                        categories: rc,
                        menuType: currentMenu,
                      ),
                    );
                  },
                );
              }
            },
          );
          break;
        case MenuType.CATEGORIES:
          final resultCategories = await getCategoriesUseCase.call();
          resultCategories.fold(
            (left) {
              emit(
                HomeStateError(
                  message: "${left.toString()}-${left.message}",
                  menuType: currentMenu,
                ),
              );
            },
            (right) {
              if (right.isEmpty) {
                emit(HomeStateItemEmpty(menuType: currentMenu));
              } else {
                emit(
                  HomeStateLoadedCategories(
                    categories: right,
                    menuType: currentMenu,
                  ),
                );
              }
            },
          );
          break;
        case MenuType.TRANSACTIONS:
          final resultTransactions = await getTransactionsUseCase.call();
          final resultProducts = await getProductsUseCase.call();
          final resultCategories = await getCategoriesUseCase.call();
          resultTransactions.fold(
            (left) {
              emit(
                HomeStateError(
                  message: "${left.toString()}-${left.message}",
                  menuType: currentMenu,
                ),
              );
            },
            (right) {
              if (right.isEmpty) {
                emit(HomeStateItemEmpty(menuType: currentMenu));
              } else {
                resultProducts.fold(
                  (left) {
                    emit(
                      HomeStateError(
                        message: "${left.toString()}-${left.message}",
                        menuType: currentMenu,
                      ),
                    );
                  },
                  (rp) {
                    resultCategories.fold(
                      (left) {
                        emit(
                          HomeStateError(
                            message: "${left.toString()}-${left.message}",
                            menuType: currentMenu,
                          ),
                        );
                      },
                      (rc) {
                        emit(
                          HomeStateLoadedTransactions(
                            transactions: right,
                            products: rp,
                            categories: rc,
                            menuType: currentMenu,
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
          break;
      }
    } catch (e) {
      emit(HomeStateError(message: e.toString(), menuType: currentMenu));
    }
  }

  FutureOr<void> _onChangeMenuView(
    HomeEventChangeMenuView event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: event.menuType));
    await _loadItemsByMenu(event.menuType, emit);
  }

  FutureOr<void> _onDeleteProduct(
    HomeEventDeleteProduct event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: state.menuType));
    final result = await deleteProductUseCase.call(event.productId);
    result.fold(
      (left) {
        log(left.message, name: "HomeBloc");
      },
      (right) {
        log("Product Deleted", name: "HomeBloc");
        add(const HomeEventGetItems());
      },
    );
  }

  FutureOr<void> _onAddProduct(
    HomeEventAddProduct event,
    Emitter<HomeState> emit,
  ) async {
    final result = await insertProductUseCase.call(event.productEntity);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc");
      },
      (r) async {
        log("Product Added", name: "HomeBloc");
      },
    );
  }

  FutureOr<void> _onUpdateProduct(
    HomeEventUpdateProduct event,
    Emitter<HomeState> emit,
  ) async {
    final result = await updateProductUseCase.call(event.productEntity);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc");
      },
      (r) async {
        log("Product Updated", name: "HomeBloc");
      },
    );
  }

  FutureOr<void> _onAddCategory(
    HomeEventAddCategory event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: state.menuType));
    final result = await insertCategoryUseCase.call(event.categoryEntity);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc");
      },
      (r) async {
        log("Category Added", name: "HomeBloc");
        add(const HomeEventGetItems());
      },
    );
  }

  FutureOr<void> _onDeleteCategory(
    HomeEventDeleteCategory event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: state.menuType));
    final result = await deleteCategoryUseCase.call(event.categoryId);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc");
      },
      (r) async {
        log("Category Deleted", name: "HomeBloc");
        add(const HomeEventGetItems());
      },
    );
  }

  FutureOr<void> _onAddTransaction(
    HomeEventAddTransaction event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: state.menuType));
    if (event.transactionEntity.type == TransactionType.MASUK) {
      await updateProductUseCase.call(
        event.transactionEntity.product.copyWith(
          quantity:
              event.transactionEntity.product.quantity +
              event.transactionEntity.amount,
        ),
      );
    } else {
      await updateProductUseCase.call(
        event.transactionEntity.product.copyWith(
          quantity:
              event.transactionEntity.product.quantity -
              event.transactionEntity.amount,
        ),
      );
    }
    final result = await insertTransactionUseCase.call(event.transactionEntity);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc");
      },
      (r) async {
        log("Transaction Added", name: "HomeBloc");
        add(const HomeEventGetItems());
      },
    );
  }

  FutureOr<void> _onDeleteTransaction(
    HomeEventDeleteTransaction event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading(menuType: state.menuType));
    await updateProductUseCase.call(
      event.productEntity.copyWith(
        quantity: event.productEntity.quantity + event.amountTransaction,
      ),
    );
    final result = await deleteTransactionUseCase.call(event.transactionId);
    result.fold(
      (l) {
        log(l.message, name: "HomeBloc", error: l);
      },
      (r) async {
        log("Transaction Deleted", name: "HomeBloc");
        add(const HomeEventGetItems());
      },
    );
  }

  FutureOr<void> _onLoadProductsOnly(
    HomeEventLoadProductsOnly event,
    Emitter<HomeState> emit,
  ) async {
    final resultProduct = await getProductsUseCase.call();
    final resultCategories = await getCategoriesUseCase.call();
    resultProduct.fold(
      (left) {
        log(left.message, name: "HomeBloc");
      },
      (right) {
        resultCategories.fold(
          (left) {
            log(left.message, name: "HomeBloc");
          },
          (rc) {
            emit(
              HomeStateLoadedProducts(
                products: right,
                categories: rc,
                menuType: state.menuType, // Jangan ubah menuType
              ),
            );
          },
        );
      },
    );
  }
}
