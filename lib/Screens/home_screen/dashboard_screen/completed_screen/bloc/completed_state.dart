part of 'completed_bloc.dart';

sealed class CompletedState extends Equatable {
  const CompletedState();
}

final class CompletedInitial extends CompletedState {
  @override
  List<Object> get props => [];
}

class CompletedGetOrdersLoadingState extends CompletedState {
  final bool isLoading;

  const CompletedGetOrdersLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedGetOrdersSuccessState extends CompletedState {
  final List<get_completed.Data> partyList;
  final String? successMessage;

  const CompletedGetOrdersSuccessState({required this.partyList, required this.successMessage});

  @override
  List<Object?> get props => [partyList, successMessage];
}

class CompletedGetOrdersFailedState extends CompletedState {
  @override
  List<Object?> get props => [];
}

class CompletedSearchOrderState extends CompletedState {
  final List<get_completed.Data> ordersList;

  const CompletedSearchOrderState({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class CompletedEditQuantityLoadingState extends CompletedState {
  final bool isLoading;

  const CompletedEditQuantityLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedEditQuantitySuccessState extends CompletedState {
  final String? successMessage;

  const CompletedEditQuantitySuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CompletedEditQuantityFailedState extends CompletedState {
  final String? failedMessage;

  const CompletedEditQuantityFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class CompletedArchiveOrderLoadingState extends CompletedState {
  final bool isLoading;

  const CompletedArchiveOrderLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedArchiveOrderSuccessState extends CompletedState {
  final String? successMessage;

  const CompletedArchiveOrderSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CompletedArchiveOrderFailedState extends CompletedState {
  final String? failedMessage;

  const CompletedArchiveOrderFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
