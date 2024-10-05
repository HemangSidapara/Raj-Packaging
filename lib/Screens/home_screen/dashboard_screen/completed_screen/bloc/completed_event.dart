part of 'completed_bloc.dart';

sealed class CompletedEvent extends Equatable {
  const CompletedEvent();
}

class CompletedStartedEvent extends CompletedEvent {
  @override
  List<Object?> get props => [];
}

class CompletedGetOrdersEvent extends CompletedEvent {
  @override
  List<Object?> get props => [];
}

class CompletedGetOrdersLoadingEvent extends CompletedEvent {
  final bool isLoading;

  const CompletedGetOrdersLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedGetOrdersSuccessEvent extends CompletedEvent {
  final List<get_completed.Data> ordersList;
  final String? successMessage;

  const CompletedGetOrdersSuccessEvent({required this.ordersList, this.successMessage});

  @override
  List<Object?> get props => [ordersList, successMessage];
}

class CompletedGetOrdersFailedEvent extends CompletedEvent {
  @override
  List<Object?> get props => [];
}

class CompletedSearchOrderEvent extends CompletedEvent {
  final List<get_completed.Data> ordersList;

  const CompletedSearchOrderEvent({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class CompletedEditQuantityClickEvent extends CompletedEvent {
  final bool isValidate;
  final String orderId;
  final String orderQuantity;

  const CompletedEditQuantityClickEvent({
    required this.isValidate,
    required this.orderId,
    required this.orderQuantity,
  });

  @override
  List<Object?> get props => [
        isValidate,
        orderId,
        orderQuantity,
      ];
}

class CompletedEditQuantityLoadingEvent extends CompletedEvent {
  final bool isLoading;

  const CompletedEditQuantityLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedEditQuantitySuccessEvent extends CompletedEvent {
  final String? successMessage;

  const CompletedEditQuantitySuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CompletedEditQuantityFailedEvent extends CompletedEvent {
  final String? failedMessage;

  const CompletedEditQuantityFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class CompletedArchiveOrderClickEvent extends CompletedEvent {
  final String orderId;

  const CompletedArchiveOrderClickEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class CompletedArchiveOrderLoadingEvent extends CompletedEvent {
  final bool isLoading;

  const CompletedArchiveOrderLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CompletedArchiveOrderSuccessEvent extends CompletedEvent {
  final String? successMessage;

  const CompletedArchiveOrderSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CompletedArchiveOrderFailedEvent extends CompletedEvent {
  final String? failedMessage;

  const CompletedArchiveOrderFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
