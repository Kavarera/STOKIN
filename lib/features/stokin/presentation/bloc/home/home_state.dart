part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final MenuType menuType;

  const HomeState({required this.menuType});

  @override
  List<Object> get props => [menuType];
}

class HomeStateItemEmpty extends HomeState {
  const HomeStateItemEmpty({required super.menuType});
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading({required super.menuType});
}

class HomeStateError extends HomeState {
  final String message;

  const HomeStateError({required this.message, required super.menuType});

  @override
  List<Object> get props => super.props + [message];
}

class HomeStateLoadedProducts extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  const HomeStateLoadedProducts({
    required this.products,
    required this.categories,
    required super.menuType,
  });

  @override
  List<Object> get props => super.props + [products, categories];
}

class HomeStateLoadedCategories extends HomeState {
  final List<CategoryEntity> categories;

  const HomeStateLoadedCategories({
    required this.categories,
    required super.menuType,
  });

  @override
  List<Object> get props => super.props + [categories];
}

class HomeStateLoadedTransactions extends HomeState {
  final List<TransactionEntity> transactions;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  const HomeStateLoadedTransactions({
    required this.transactions,
    required this.products,
    required this.categories,
    required super.menuType,
  });

  @override
  List<Object> get props => super.props + [transactions, products, categories];
}
