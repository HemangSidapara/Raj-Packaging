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

class InventoryEntryTypeEvent extends InventoryEvent {
  final int entryTypeIndex;

  const InventoryEntryTypeEvent({this.entryTypeIndex = 0});

  @override
  List<Object?> get props => [entryTypeIndex];
}

class InventoryItemsTypeEvent extends InventoryEvent {
  final int itemsTypeIndex;

  const InventoryItemsTypeEvent({this.itemsTypeIndex = 0});

  @override
  List<Object?> get props => [itemsTypeIndex];
}

class InventoryEntryButtonClickEvent extends InventoryEvent {
  final bool isValidate;
  final String entryType;
  final String itemType;
  final String size;
  final String gsm;
  final String bf;
  final String shade;
  final String weight;
  final String quantity;

  const InventoryEntryButtonClickEvent({
    required this.isValidate,
    required this.entryType,
    required this.itemType,
    required this.size,
    required this.gsm,
    required this.bf,
    required this.shade,
    required this.weight,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        isValidate,
        entryType,
        itemType,
        size,
        gsm,
        bf,
        shade,
        weight,
        quantity,
      ];
}

class InventoryEntryLoadingEvent extends InventoryEvent {
  final bool isLoading;

  const InventoryEntryLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InventoryEntrySuccessEvent extends InventoryEvent {
  final String? successMessage;

  const InventoryEntrySuccessEvent({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class InventoryEntryFailedEvent extends InventoryEvent {
  @override
  List<Object?> get props => [];
}
