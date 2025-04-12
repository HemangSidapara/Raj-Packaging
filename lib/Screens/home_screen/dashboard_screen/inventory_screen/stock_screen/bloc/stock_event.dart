part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();
}

class StockStartedEvent extends StockEvent {
  const StockStartedEvent();

  @override
  List<Object> get props => [];
}

class StockGetInventoryEvent extends StockEvent {
  final bool isLoading;

  const StockGetInventoryEvent({this.isLoading = true});

  @override
  List<Object?> get props => [isLoading];
}

class StockGetInventoryLoadingEvent extends StockEvent {
  final bool isLoading;

  const StockGetInventoryLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class StockGetInventorySuccessEvent extends StockEvent {
  final List<get_inventory.Data> inventoryList;
  final String? successMessage;

  const StockGetInventorySuccessEvent({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class StockGetInventoryFailedEvent extends StockEvent {
  final List<get_inventory.Data> inventoryList;

  const StockGetInventoryFailedEvent({required this.inventoryList});

  @override
  List<Object?> get props => [inventoryList];
}
