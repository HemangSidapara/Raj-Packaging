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

class CreateOrderPlySheetTypeEvent extends CreateOrderEvent {
  final int plySheetTypeIndex;

  const CreateOrderPlySheetTypeEvent({this.plySheetTypeIndex = 0});

  @override
  List<Object?> get props => [plySheetTypeIndex];
}

class CreateOrderBoxTypeEvent extends CreateOrderEvent {
  final int boxTypeIndex;

  const CreateOrderBoxTypeEvent({this.boxTypeIndex = 0});

  @override
  List<Object?> get props => [boxTypeIndex];
}

class CreateOrderPlyBoxRSCTypeEvent extends CreateOrderEvent {
  final int plyBoxRSCTypeIndex;

  const CreateOrderPlyBoxRSCTypeEvent({this.plyBoxRSCTypeIndex = 0});

  @override
  List<Object?> get props => [plyBoxRSCTypeIndex];
}

class CreateOrderPlyBoxDiePunchTypeEvent extends CreateOrderEvent {
  final int plyBoxDiePunchTypeIndex;

  const CreateOrderPlyBoxDiePunchTypeEvent({this.plyBoxDiePunchTypeIndex = 0});

  @override
  List<Object?> get props => [plyBoxDiePunchTypeIndex];
}
