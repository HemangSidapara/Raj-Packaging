part of 'inventory_bloc.dart';

sealed class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class InventoryStartedEvent extends InventoryEvent {
  const InventoryStartedEvent();

  @override
  List<Object> get props => [];
}

class InventoryGetInventoryEvent extends InventoryEvent {
  final bool isLoading;

  const InventoryGetInventoryEvent({this.isLoading = true});

  @override
  List<Object?> get props => [isLoading];
}

class InventoryGetInventoryLoadingEvent extends InventoryEvent {
  final bool isLoading;

  const InventoryGetInventoryLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InventoryGetInventorySuccessEvent extends InventoryEvent {
  final List inventoryList;
  final String? successMessage;

  const InventoryGetInventorySuccessEvent({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class InventoryGetInventoryFailedEvent extends InventoryEvent {
  final List inventoryList;

  const InventoryGetInventoryFailedEvent({required this.inventoryList});

  @override
  List<Object?> get props => [inventoryList];
}
