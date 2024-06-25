part of 'pending_orders_bloc.dart';

sealed class PendingOrdersEvent extends Equatable {
  const PendingOrdersEvent();
}

class PendingOrdersStartedEvent extends PendingOrdersEvent {
  @override
  List<Object?> get props => [];
}

class PendingOrdersGetOrdersEvent extends PendingOrdersEvent {
  @override
  List<Object?> get props => [];
}

class PendingOrdersGetOrdersLoadingEvent extends PendingOrdersEvent {
  final bool isLoading;

  const PendingOrdersGetOrdersLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersGetOrdersSuccessEvent extends PendingOrdersEvent {
  final List<get_orders.Data> ordersList;
  final String? successMessage;

  const PendingOrdersGetOrdersSuccessEvent({required this.ordersList, this.successMessage});

  @override
  List<Object?> get props => [ordersList, successMessage];
}

class PendingOrdersGetOrdersFailedEvent extends PendingOrdersEvent {
  @override
  List<Object?> get props => [];
}

class PendingOrdersSearchOrderEvent extends PendingOrdersEvent {
  final List<get_orders.Data> ordersList;

  const PendingOrdersSearchOrderEvent({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}
