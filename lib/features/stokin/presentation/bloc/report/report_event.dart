part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class ReportEventLoadItems extends ReportEvent {
  const ReportEventLoadItems();
}

class ReportEventCategoryFilter extends ReportEvent {
  final int categoryId;

  const ReportEventCategoryFilter(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ReportEventMonthFilter extends ReportEvent {
  final DateTime? month;
  const ReportEventMonthFilter(this.month);

  @override
  List<Object?> get props => [month];
}

class ReportEventProductFilter extends ReportEvent {
  final int productId;

  const ReportEventProductFilter(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ReportEventClearFilter extends ReportEvent {
  const ReportEventClearFilter();
}
