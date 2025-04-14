import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapp_bloc/core/data/menu_type_enum.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/product_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/transaction_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/usecases/product_usecase.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/usecases/transaction_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductUsecase getProductUsecase;
  final GetTransactionUseCase getTransactionUseCase;
  final InsertProductUsecase insertProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  HomeBloc(
    this.getProductUsecase,
    this.getTransactionUseCase,
    this.insertProductUsecase,
    this.updateProductUsecase,
    this.deleteProductUsecase,
    this.deleteTransactionUseCase,
  ) : super(
        HomeStateItemEmpty(
          menuType: MenuType.PRODUCTS,
          products: <ProductEntity>[],
          transactions: <TransactionEntity>[],
        ),
      ) {
    on<HomeEventChangeMenuType>(_onChangeMenuType);
    on<HomeEventGetItems>(_onGetItems);
    on<HomeEventAddProduct>(_onAddProduct);
    on<HomeEventDeleteItem>(_onDeleteItem);
    on<HomeEventUpdateProduct>(_onUpdateProduct);
    add(const HomeEventGetItems(MenuType.PRODUCTS));
  }

  FutureOr<void> _onChangeMenuType(
    HomeEventChangeMenuType event,
    Emitter<HomeState> emit,
  ) async {
    log('Change Menu Type', name: 'HomeBloc');
    if (event.menuType == MenuType.PRODUCTS) {
      log('Change to Products', name: 'HomeBloc');
      add(const HomeEventGetItems(MenuType.PRODUCTS));
    } else if (event.menuType == MenuType.TRANSACTIONS) {
      log('Change to Transactions', name: 'HomeBloc');
      add(const HomeEventGetItems(MenuType.TRANSACTIONS));
    }
  }

  FutureOr<void> _onGetItems(
    HomeEventGetItems event,
    Emitter<HomeState> emit,
  ) async {
    final products = await getProductUsecase.call();
    final transactions = await getTransactionUseCase.call();
    emit(
      HomeStateLoadedItems(
        menuType: event.menuType,
        products: products,
        transactions: transactions,
      ),
    );
  }

  FutureOr<void> _onAddProduct(
    HomeEventAddProduct event,
    Emitter<HomeState> emit,
  ) async {
    final product = ProductEntity(
      id: 0,
      name: event.productName,
      price: double.parse(event.productPrice),
    );
    await insertProductUsecase.call(product);
    final products = await getProductUsecase.call();
    emit(
      HomeStateLoadedItems(
        menuType: state.menuType,
        products: products,
        transactions: state.transactions,
      ),
    );
  }

  FutureOr<void> _onDeleteItem(
    HomeEventDeleteItem event,
    Emitter<HomeState> emit,
  ) async {
    if (state.menuType == MenuType.PRODUCTS) {
      await deleteProductUsecase.call(state.products[event.index].id);
      final products = await getProductUsecase.call();
      emit(
        HomeStateLoadedItems(
          menuType: state.menuType,
          products: products,
          transactions: state.transactions,
        ),
      );
    } else if (state.menuType == MenuType.TRANSACTIONS) {
      await deleteTransactionUseCase.call(state.transactions[event.index].id);
      final transactions = await getTransactionUseCase.call();
      emit(
        HomeStateLoadedItems(
          menuType: state.menuType,
          products: state.products,
          transactions: transactions,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateProduct(
    HomeEventUpdateProduct event,
    Emitter<HomeState> emit,
  ) async {
    await updateProductUsecase.call(
      state.products
          .firstWhere((e) => e.id == event.id)
          .copyWith(
            name: event.productName,
            price: double.parse(event.productPrice),
          ),
    );
    final products = await getProductUsecase.call();
    emit(
      HomeStateLoadedItems(
        menuType: state.menuType,
        products: products,
        transactions: state.transactions,
      ),
    );
  }
}
