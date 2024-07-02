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

class PendingOrdersEditPartyClickEvent extends PendingOrdersEvent {
  final bool isValidate;
  final String partyId;
  final String partyName;
  final String partyPhone;

  const PendingOrdersEditPartyClickEvent({
    required this.isValidate,
    required this.partyId,
    required this.partyName,
    required this.partyPhone,
  });

  @override
  List<Object?> get props => [
        isValidate,
        partyId,
        partyName,
        partyPhone,
      ];
}

class PendingOrdersEditPartyLoadingEvent extends PendingOrdersEvent {
  final bool isLoading;

  const PendingOrdersEditPartyLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersEditPartySuccessEvent extends PendingOrdersEvent {
  final String? successMessage;

  const PendingOrdersEditPartySuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class PendingOrdersEditPartyFailedEvent extends PendingOrdersEvent {
  final String? failedMessage;

  const PendingOrdersEditPartyFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class PendingOrdersDeleteOrderClickEvent extends PendingOrdersEvent {
  final String orderId;

  const PendingOrdersDeleteOrderClickEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class PendingOrdersDeleteOrderLoadingEvent extends PendingOrdersEvent {
  final bool isLoading;

  const PendingOrdersDeleteOrderLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class PendingOrdersDeleteOrderSuccessEvent extends PendingOrdersEvent {
  final String? successMessage;

  const PendingOrdersDeleteOrderSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class PendingOrdersDeleteOrderFailedEvent extends PendingOrdersEvent {
  final String? failedMessage;

  const PendingOrdersDeleteOrderFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
