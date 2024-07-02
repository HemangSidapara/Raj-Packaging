part of 'pending_orders_bloc.dart';

sealed class PendingOrdersState extends Equatable {
  const PendingOrdersState();
}

final class PendingOrdersInitial extends PendingOrdersState {
  @override
  List<Object> get props => [];
}

class PendingOrdersGetOrdersLoadingState extends PendingOrdersState {
  final bool isLoading;

  const PendingOrdersGetOrdersLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersGetOrdersSuccessState extends PendingOrdersState {
  final List<get_orders.Data> partyList;
  final String? successMessage;

  const PendingOrdersGetOrdersSuccessState({required this.partyList, required this.successMessage});

  @override
  List<Object?> get props => [partyList, successMessage];
}

class PendingOrdersGetOrdersFailedState extends PendingOrdersState {
  @override
  List<Object?> get props => [];
}

class PendingOrdersSearchOrderState extends PendingOrdersState {
  final List<get_orders.Data> ordersList;

  const PendingOrdersSearchOrderState({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class PendingOrdersEditPartyLoadingState extends PendingOrdersState {
  final bool isLoading;

  const PendingOrdersEditPartyLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersEditPartySuccessState extends PendingOrdersState {
  final String? successMessage;

  const PendingOrdersEditPartySuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class PendingOrdersEditPartyFailedState extends PendingOrdersState {
  final String? failedMessage;

  const PendingOrdersEditPartyFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class PendingOrdersDeleteOrderLoadingState extends PendingOrdersState {
  final bool isLoading;

  const PendingOrdersDeleteOrderLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersDeleteOrderSuccessState extends PendingOrdersState {
  final String? successMessage;

  const PendingOrdersDeleteOrderSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class PendingOrdersDeleteOrderFailedState extends PendingOrdersState {
  final String? failedMessage;

  const PendingOrdersDeleteOrderFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
