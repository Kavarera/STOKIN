part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();
  @override
  List<Object?> get props => [];
}

class ReportEventLoadTransactions extends ReportEvent {
  final DateTime? selectedDate;

  const ReportEventLoadTransactions({this.selectedDate});
  @override
  List<Object?> get props => [selectedDate];
}
