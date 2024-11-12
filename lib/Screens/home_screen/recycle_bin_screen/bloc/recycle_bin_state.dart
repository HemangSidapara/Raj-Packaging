part of 'recycle_bin_bloc.dart';

sealed class RecycleBinState extends Equatable {
  const RecycleBinState();
}

final class RecycleBinInitial extends RecycleBinState {
  @override
  List<Object> get props => [];
}

class RecycleBinGetOrdersLoadingState extends RecycleBinState {
  final bool isLoading;

  const RecycleBinGetOrdersLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class RecycleBinGetOrdersSuccessState extends RecycleBinState {
  final List<get_recycle_bin.Data> partyList;
  final String? successMessage;

  const RecycleBinGetOrdersSuccessState({required this.partyList, required this.successMessage});

  @override
  List<Object?> get props => [partyList, successMessage];
}

class RecycleBinGetOrdersFailedState extends RecycleBinState {
  @override
  List<Object?> get props => [];
}

class RecycleBinSearchOrderState extends RecycleBinState {
  final List<get_recycle_bin.Data> ordersList;

  const RecycleBinSearchOrderState({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}
