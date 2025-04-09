part of 'production_report_bloc.dart';

sealed class ProductionReportState extends Equatable {
  const ProductionReportState();
}

class ProductionReportInitial extends ProductionReportState {
  const ProductionReportInitial();

  @override
  List<Object?> get props => [];
}

class ProductionReportGetProductionLoadingState extends ProductionReportState {
  final bool isLoading;

  const ProductionReportGetProductionLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class ProductionReportGetProductionSuccessState extends ProductionReportState {
  final List productionList;
  final String? successMessage;

  const ProductionReportGetProductionSuccessState({required this.productionList, required this.successMessage});

  @override
  List<Object?> get props => [productionList, successMessage];
}

class ProductionReportGetProductionFailedState extends ProductionReportState {
  @override
  List<Object?> get props => [];
}
