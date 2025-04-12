part of 'add_bloc.dart';

sealed class AddEvent extends Equatable {
  const AddEvent();
}

class AddStartedEvent extends AddEvent {
  const AddStartedEvent();

  @override
  List<Object> get props => [];
}

class AddGetInventoryEvent extends AddEvent {
  final bool isLoading;

  const AddGetInventoryEvent({this.isLoading = true});

  @override
  List<Object?> get props => [isLoading];
}

class AddGetInventoryLoadingEvent extends AddEvent {
  final bool isLoading;

  const AddGetInventoryLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AddGetInventorySuccessEvent extends AddEvent {
  final List<get_inventory.Data> inventoryList;
  final String? successMessage;

  const AddGetInventorySuccessEvent({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class AddGetInventoryFailedEvent extends AddEvent {
  final List<get_inventory.Data> inventoryList;

  const AddGetInventoryFailedEvent({required this.inventoryList});

  @override
  List<Object?> get props => [inventoryList];
}

class AddTypeEvent extends AddEvent {
  final int entryTypeIndex;

  const AddTypeEvent({this.entryTypeIndex = 0});

  @override
  List<Object?> get props => [entryTypeIndex];
}

class AddItemsTypeEvent extends AddEvent {
  final int itemsTypeIndex;

  const AddItemsTypeEvent({this.itemsTypeIndex = 0});

  @override
  List<Object?> get props => [itemsTypeIndex];
}

class AddButtonClickEvent extends AddEvent {
  final bool isValidate;
  final String entryType;
  final String itemType;
  final String size;
  final String gsm;
  final String bf;
  final String shade;
  final String weight;
  final String quantity;

  const AddButtonClickEvent({
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

class AddLoadingEvent extends AddEvent {
  final bool isLoading;

  const AddLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AddSuccessEvent extends AddEvent {
  final String? successMessage;

  const AddSuccessEvent({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class AddFailedEvent extends AddEvent {
  @override
  List<Object?> get props => [];
}
