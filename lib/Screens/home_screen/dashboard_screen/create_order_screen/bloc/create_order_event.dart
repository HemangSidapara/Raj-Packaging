part of 'create_order_bloc.dart';

sealed class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();
}

class CreateOrderStartedEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderGetPartiesEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderGetPartiesLoadingEvent extends CreateOrderEvent {
  final bool isLoading;

  const CreateOrderGetPartiesLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderGetPartiesSuccessEvent extends CreateOrderEvent {
  final List<get_orders.Data> partyList;
  final String? successMessage;

  const CreateOrderGetPartiesSuccessEvent({required this.partyList, this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderGetPartiesFailedEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderEditPartyClickEvent extends CreateOrderEvent {
  final bool isValidate;
  final String partyId;
  final String partyName;
  final String partyPhone;

  const CreateOrderEditPartyClickEvent({
    required this.isValidate,
    required this.partyId,
    required this.partyName,
    required this.partyPhone,
  });

  @override
  List<Object?> get props => [
        isValidate,
        partyId,
        partyName,
        partyPhone,
      ];
}

class CreateOrderEditPartyLoadingEvent extends CreateOrderEvent {
  final bool isLoading;

  const CreateOrderEditPartyLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderEditPartySuccessEvent extends CreateOrderEvent {
  final String? successMessage;

  const CreateOrderEditPartySuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderEditPartyFailedEvent extends CreateOrderEvent {
  final String? failedMessage;

  const CreateOrderEditPartyFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class CreateOrderSelectedPartyEvent extends CreateOrderEvent {
  final String? partyId;

  const CreateOrderSelectedPartyEvent({required this.partyId});

  @override
  List<Object?> get props => [partyId];
}

class CreateOrderSelectedProductEvent extends CreateOrderEvent {
  final String? productId;

  const CreateOrderSelectedProductEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
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
  final String? partyId;
  final String? productId;
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
    this.partyId,
    this.productId,
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
  List<Object?> get props => [
        isValidate,
        partyId,
        productId,
        partyName,
        partyPhone,
        orderType,
        boxType,
        productName,
        orderQuantity,
        productionDeckle,
        productionCutting,
        productionQuantity,
        deckle,
        cutting,
        ply,
        topPaper,
        paper,
        flute,
        l,
        b,
        h,
      ];
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
