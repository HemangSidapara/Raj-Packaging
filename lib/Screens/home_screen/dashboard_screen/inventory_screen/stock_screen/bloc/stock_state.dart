part of 'stock_bloc.dart';

sealed class StockState extends Equatable {
  const StockState();
}

class StockInitial extends StockState {
  const StockInitial();

  @override
  List<Object?> get props => [];
}

class StockGetInventoryLoadingState extends StockState {
  final bool isLoading;

  const StockGetInventoryLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class StockGetInventorySuccessState extends StockState {
  final List<get_inventory.Data> inventoryList;
  final String? successMessage;

  const StockGetInventorySuccessState({required this.inventoryList, required this.successMessage});

  @override
  List<Object?> get props => [inventoryList, successMessage];
}

class StockGetInventoryFailedState extends StockState {
  @override
  List<Object?> get props => [];
}
