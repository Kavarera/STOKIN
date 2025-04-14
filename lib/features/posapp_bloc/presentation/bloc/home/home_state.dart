part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final MenuType menuType;
  final List<ProductEntity> products;
  final List<TransactionEntity> transactions;
  const HomeState({
    required this.menuType,
    required this.products,
    required this.transactions,
  });
  @override
  List<Object?> get props => [menuType, products, transactions];
}

class HomeStateItemEmpty extends HomeState {
  const HomeStateItemEmpty({
    required super.menuType,
    required super.products,
    required super.transactions,
  });
}

class HomeStateLoadedItems extends HomeState {
  const HomeStateLoadedItems({
    required super.menuType,
    required super.products,
    required super.transactions,
  });
}
