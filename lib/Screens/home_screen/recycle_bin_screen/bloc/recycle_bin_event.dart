part of 'recycle_bin_bloc.dart';

sealed class RecycleBinEvent extends Equatable {
  const RecycleBinEvent();
}

class RecycleBinStartedEvent extends RecycleBinEvent {
  @override
  List<Object?> get props => [];
}

class RecycleBinGetOrdersEvent extends RecycleBinEvent {
  @override
  List<Object?> get props => [];
}

class RecycleBinGetOrdersLoadingEvent extends RecycleBinEvent {
  final bool isLoading;

  const RecycleBinGetOrdersLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class RecycleBinGetOrdersSuccessEvent extends RecycleBinEvent {
  final List<get_recycle_bin.Data> ordersList;
  final String? successMessage;

  const RecycleBinGetOrdersSuccessEvent({required this.ordersList, this.successMessage});

  @override
  List<Object?> get props => [ordersList, successMessage];
}

class RecycleBinGetOrdersFailedEvent extends RecycleBinEvent {
  @override
  List<Object?> get props => [];
}

class RecycleBinSearchOrderEvent extends RecycleBinEvent {
  final List<get_recycle_bin.Data> ordersList;

  const RecycleBinSearchOrderEvent({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}
