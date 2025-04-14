part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeEventChangeMenuType extends HomeEvent {
  final MenuType menuType;
  const HomeEventChangeMenuType(this.menuType);
  @override
  List<Object?> get props => [menuType];
}

class HomeEventAddProduct extends HomeEvent {
  final String productName;
  final String productPrice;
  const HomeEventAddProduct(this.productName, this.productPrice);
  @override
  List<Object?> get props => [productName, productPrice];
}

class HomeEventGetItems extends HomeEvent {
  final MenuType menuType;
  const HomeEventGetItems(this.menuType);
  @override
  List<Object?> get props => [menuType];
}

class HomeEventDeleteItem extends HomeEvent {
  final int index;
  const HomeEventDeleteItem(this.index);
  @override
  List<Object?> get props => [index];
}

class HomeEventUpdateProduct extends HomeEvent {
  final int id;
  final String productName;
  final String productPrice;
  const HomeEventUpdateProduct(this.id, this.productName, this.productPrice);
  @override
  List<Object?> get props => [id, productName, productPrice];
}
