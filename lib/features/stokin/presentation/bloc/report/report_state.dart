part of 'report_bloc.dart';

class ReportState extends Equatable {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<TransactionEntity> transactions;

  final int selectedCategoryId;
  final DateTime? selectedMonth;
  final int selectedProductId;
  const ReportState({
    this.products = const [],
    this.categories = const [],
    this.transactions = const [],
    this.selectedCategoryId = 0,
    this.selectedMonth,
    this.selectedProductId = 0,
  });

  ReportState copyWith({
    List<ProductEntity>? products,
    List<CategoryEntity>? categories,
    List<TransactionEntity>? transactions,
    int? selectedCategoryId,
    DateTime? selectedMonth,
    int? selectedProductId,
  }) {
    return ReportState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      transactions: transactions ?? this.transactions,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedMonth: selectedMonth,
      selectedProductId: selectedProductId ?? this.selectedProductId,
    );
  }

  @override
  List<Object?> get props => [
    products,
    categories,
    transactions,
    selectedCategoryId,
    selectedMonth,
    selectedProductId,
  ];
}
