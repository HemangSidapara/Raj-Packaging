part of 'create_order_bloc.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();
}

final class CreateOrderInitial extends CreateOrderState {
  @override
  List<Object> get props => [];
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
