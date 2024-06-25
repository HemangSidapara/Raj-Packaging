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
