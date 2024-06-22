part of 'create_order_bloc.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();
}

final class CreateOrderInitial extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class CreateOrderGetPartiesLoadingState extends CreateOrderState {
  final bool isLoading;

  const CreateOrderGetPartiesLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderGetPartiesSuccessState extends CreateOrderState {
  final List<get_orders.Data> partyList;
  final String? successMessage;

  const CreateOrderGetPartiesSuccessState({required this.partyList, required this.successMessage});

  @override
  List<Object?> get props => [partyList, successMessage];
}

class CreateOrderGetPartiesFailedState extends CreateOrderState {
  @override
  List<Object?> get props => [];
}

class CreateOrderEditPartyLoadingState extends CreateOrderState {
  final bool isLoading;

  const CreateOrderEditPartyLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderEditPartySuccessState extends CreateOrderState {
  final String? successMessage;

  const CreateOrderEditPartySuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderEditPartyFailedState extends CreateOrderState {
  final String? failedMessage;

  const CreateOrderEditPartyFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class CreateOrderSelectedPartyState extends CreateOrderState {
  final List<get_orders.ProductData> productList;
  final String? partyId;

  const CreateOrderSelectedPartyState({required this.productList, required this.partyId});

  @override
  List<Object?> get props => [productList, partyId];
}

class CreateOrderSelectedProductState extends CreateOrderState {
  final String? productId;

  const CreateOrderSelectedProductState({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class CreateOrderTypeState extends CreateOrderState {
  final int orderTypeIndex;

  const CreateOrderTypeState({this.orderTypeIndex = 0});

  @override
  List<Object?> get props => [orderTypeIndex];
}

class CreateOrderPlySheetTypeState extends CreateOrderState {
  final int plySheetTypeIndex;

  const CreateOrderPlySheetTypeState({this.plySheetTypeIndex = 0});

  @override
  List<Object?> get props => [plySheetTypeIndex];
}

class CreateOrderBoxTypeState extends CreateOrderState {
  final int boxTypeIndex;

  const CreateOrderBoxTypeState({this.boxTypeIndex = 0});

  @override
  List<Object?> get props => [boxTypeIndex];
}

class CreateOrderPlyBoxRSCTypeState extends CreateOrderState {
  final int plyBoxRSCTypeIndex;

  const CreateOrderPlyBoxRSCTypeState({this.plyBoxRSCTypeIndex = 0});

  @override
  List<Object?> get props => [plyBoxRSCTypeIndex];
}

class CreateOrderPlyBoxDiePunchTypeState extends CreateOrderState {
  final int plyBoxDiePunchTypeIndex;

  const CreateOrderPlyBoxDiePunchTypeState({this.plyBoxDiePunchTypeIndex = 0});

  @override
  List<Object?> get props => [plyBoxDiePunchTypeIndex];
}

class CreateOrderLoadingState extends CreateOrderState {
  final bool isLoading;

  const CreateOrderLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderSuccessState extends CreateOrderState {
  final String? successMessage;

  const CreateOrderSuccessState({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderFailedState extends CreateOrderState {
  @override
  List<Object?> get props => [];
}
