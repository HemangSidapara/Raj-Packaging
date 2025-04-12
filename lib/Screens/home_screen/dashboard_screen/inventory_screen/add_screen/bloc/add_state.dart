part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();
}

class AddInitial extends AddState {
  const AddInitial();

  @override
  List<Object?> get props => [];
}

class AddGetInventoryLoadingState extends AddState {
  final bool isLoading;

  const AddGetInventoryLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AddGetInventorySuccessState extends AddState {
  final List<get_inventory.Data> inventoryList;
  final String? successMessage;

  const AddGetInventorySuccessState({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class AddGetInventoryFailedState extends AddState {
  @override
  List<Object?> get props => [];
}

class AddTypeState extends AddState {
  final int entryTypeIndex;

  const AddTypeState({this.entryTypeIndex = 0});

  @override
  List<Object?> get props => [entryTypeIndex];
}

class AddItemsTypeState extends AddState {
  final int itemsTypeIndex;

  const AddItemsTypeState({this.itemsTypeIndex = 0});

  @override
  List<Object?> get props => [itemsTypeIndex];
}

class AddLoadingState extends AddState {
  final bool isLoading;

  const AddLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AddSuccessState extends AddState {
  final String? successMessage;

  const AddSuccessState({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class AddFailedState extends AddState {
  @override
  List<Object?> get props => [];
}
