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

class CreateOrderPlyTypeState extends CreateOrderState {
  final int plyTypeIndex;

  const CreateOrderPlyTypeState({this.plyTypeIndex = 0});

  @override
  List<Object?> get props => [plyTypeIndex];
}

class CreateOrderBoxTypeState extends CreateOrderState {
  final int boxTypeIndex;

  const CreateOrderBoxTypeState({this.boxTypeIndex = 0});

  @override
  List<Object?> get props => [boxTypeIndex];
}
