part of 'production_report_bloc.dart';

sealed class ProductionReportEvent extends Equatable {
  const ProductionReportEvent();
}

class ProductionReportStartedEvent extends ProductionReportEvent {
  const ProductionReportStartedEvent();

  @override
  List<Object> get props => [];
}

class ProductionReportGetProductionEvent extends ProductionReportEvent {
  final bool isLoading;

  const ProductionReportGetProductionEvent({this.isLoading = true});

  @override
  List<Object?> get props => [isLoading];
}

class ProductionReportGetProductionLoadingEvent extends ProductionReportEvent {
  final bool isLoading;

  const ProductionReportGetProductionLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class ProductionReportGetProductionSuccessEvent extends ProductionReportEvent {
  final List<get_report.Data> productionList;
  final String? successMessage;

  const ProductionReportGetProductionSuccessEvent({required this.productionList, required this.successMessage});

  @override
  List<Object?> get props => [productionList, successMessage];
}

class ProductionReportGetProductionFailedEvent extends ProductionReportEvent {
  final List<get_report.Data> productionList;

  const ProductionReportGetProductionFailedEvent({required this.productionList});

  @override
  List<Object?> get props => [productionList];
}
