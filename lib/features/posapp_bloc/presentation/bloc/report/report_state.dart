part of 'report_bloc.dart';

class ReportState extends Equatable {
  final List<TransactionEntity> transactions;
  final DateTime? filterDate;

  const ReportState({required this.transactions, this.filterDate});
  @override
  List<Object?> get props => [transactions, filterDate];
}
