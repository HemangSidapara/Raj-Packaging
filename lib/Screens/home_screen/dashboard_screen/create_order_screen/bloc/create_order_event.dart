part of 'create_order_bloc.dart';

sealed class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();
}

class CreateOrderStartedEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderTypeEvent extends CreateOrderEvent {
  final int orderTypeIndex;

  const CreateOrderTypeEvent({this.orderTypeIndex = 0});

  @override
  List<Object?> get props => [orderTypeIndex];
}

class CreateOrderPlyTypeEvent extends CreateOrderEvent {
  final int plyTypeIndex;

  const CreateOrderPlyTypeEvent({this.plyTypeIndex = 0});

  @override
  List<Object?> get props => [plyTypeIndex];
}

class CreateOrderBoxTypeEvent extends CreateOrderEvent {
  final int boxTypeIndex;

  const CreateOrderBoxTypeEvent({this.boxTypeIndex = 0});

  @override
  List<Object?> get props => [boxTypeIndex];
}
