part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeEventGetItems extends HomeEvent {
  const HomeEventGetItems();
}

// Event untuk ganti menu (products, categories, transactions)
class HomeEventChangeMenuView extends HomeEvent {
  final MenuType menuType;

  const HomeEventChangeMenuView(this.menuType);

  @override
  List<Object> get props => [menuType];
}

class HomeEventDeleteProduct extends HomeEvent {
  final int productId;

  const HomeEventDeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class HomeEventAddProduct extends HomeEvent {
  final ProductEntity productEntity;

  const HomeEventAddProduct(this.productEntity);

  @override
  List<Object> get props => [productEntity];
}

class HomeEventUpdateProduct extends HomeEvent {
  final ProductEntity productEntity;

  const HomeEventUpdateProduct(this.productEntity);

  @override
  List<Object> get props => [productEntity];
}

class HomeEventAddCategory extends HomeEvent {
  final CategoryEntity categoryEntity;

  const HomeEventAddCategory(this.categoryEntity);

  @override
  List<Object> get props => [categoryEntity];
}

class HomeEventDeleteCategory extends HomeEvent {
  final int categoryId;

  const HomeEventDeleteCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class HomeEventAddTransaction extends HomeEvent {
  final TransactionEntity transactionEntity;

  const HomeEventAddTransaction(this.transactionEntity);

  @override
  List<Object> get props => [transactionEntity];
}

class HomeEventDeleteTransaction extends HomeEvent {
  final int transactionId;
  final int amountTransaction;
  final ProductEntity productEntity;
  const HomeEventDeleteTransaction(
    this.transactionId,
    this.amountTransaction,
    this.productEntity,
  );

  @override
  List<Object> get props => [transactionId];
}

class HomeEventLoadProductsOnly extends HomeEvent {
  const HomeEventLoadProductsOnly();
}
