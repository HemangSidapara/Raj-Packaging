part of 'inventory_bloc.dart';

sealed class InventoryState extends Equatable {
  const InventoryState();
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();

  @override
  List<Object?> get props => [];
}

class InventoryGetInventoryLoadingState extends InventoryState {
  final bool isLoading;

  const InventoryGetInventoryLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InventoryGetInventorySuccessState extends InventoryState {
  final List inventoryList;
  final String? successMessage;

  const InventoryGetInventorySuccessState({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class InventoryGetInventoryFailedState extends InventoryState {
  @override
  List<Object?> get props => [];
}

class InventoryEntryTypeState extends InventoryState {
  final int entryTypeIndex;

  const InventoryEntryTypeState({this.entryTypeIndex = 0});

  @override
  List<Object?> get props => [entryTypeIndex];
}

class InventoryItemsTypeState extends InventoryState {
  final int itemsTypeIndex;

  const InventoryItemsTypeState({this.itemsTypeIndex = 0});

  @override
  List<Object?> get props => [itemsTypeIndex];
}
