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

class CreateOrderButtonClickEvent extends CreateOrderEvent {
  final bool isValidate;
  final String partyName;
  final String partyPhone;
  final String orderType;
  final String? boxType;
  final String productName;
  final String orderQuantity;
  final String productionDeckle;
  final String? productionCutting;
  final String productionQuantity;
  final String deckle;
  final String? cutting;
  final String? ply;
  final String? topPaper;
  final String? paper;
  final String? flute;
  final String? l;
  final String? b;
  final String? h;

  const CreateOrderButtonClickEvent({
    required this.isValidate,
    required this.partyName,
    required this.partyPhone,
    required this.orderType,
    this.boxType,
    required this.productName,
    required this.orderQuantity,
    required this.productionDeckle,
    this.productionCutting,
    required this.productionQuantity,
    required this.deckle,
    this.cutting,
    this.ply,
    this.topPaper,
    this.paper,
    this.flute,
    this.l,
    this.b,
    this.h,
  });

  @override
  List<Object?> get props => [];
}

class CreateOrderLoadingEvent extends CreateOrderEvent {
  final bool isLoading;

  const CreateOrderLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderSuccessEvent extends CreateOrderEvent {
  final String? successMessage;

  const CreateOrderSuccessEvent({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderFailedEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}
