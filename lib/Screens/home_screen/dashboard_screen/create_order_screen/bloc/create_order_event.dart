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

class CreateOrderJointTypeEvent extends CreateOrderEvent {
  final int jointTypeIndex;

  const CreateOrderJointTypeEvent({required this.jointTypeIndex});

  @override
  List<Object?> get props => [jointTypeIndex];
}

class CreateOrderFlapTypeEvent extends CreateOrderEvent {
  final int flapTypeIndex;

  const CreateOrderFlapTypeEvent({required this.flapTypeIndex});

  @override
  List<Object?> get props => [flapTypeIndex];
}

class CreateOrderSheetBoxTypeEvent extends CreateOrderEvent {
  final int sheetBoxTypeIndex;

  const CreateOrderSheetBoxTypeEvent({required this.sheetBoxTypeIndex});

  @override
  List<Object?> get props => [sheetBoxTypeIndex];
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
  final String? ups;
  final String? jointType;
  final String? notes;
  final String? flapType;
  final String? sheetBoxType;

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
    this.ups,
    this.jointType,
    this.notes,
    this.flapType,
    this.sheetBoxType,
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
        ups,
        jointType,
        notes,
        flapType,
        sheetBoxType,
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

class SearchPartyEvent extends CreateOrderEvent {
  final List<get_orders.Data> partyList;

  const SearchPartyEvent({required this.partyList});

  @override
  List<Object?> get props => [partyList];
}

class SearchProductEvent extends CreateOrderEvent {
  final List<get_orders.ProductData> productList;

  const SearchProductEvent({required this.productList});

  @override
  List<Object?> get props => [productList];
}

class CreateOrderEditProductClickEvent extends CreateOrderEvent {
  final bool isValidate;
  final String productId;
  final String productName;

  const CreateOrderEditProductClickEvent({
    required this.isValidate,
    required this.productId,
    required this.productName,
  });

  @override
  List<Object?> get props => [
        isValidate,
        productId,
        productName,
      ];
}

class CreateOrderEditProductLoadingEvent extends CreateOrderEvent {
  final bool isLoading;

  const CreateOrderEditProductLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderEditProductSuccessEvent extends CreateOrderEvent {
  final String? successMessage;

  const CreateOrderEditProductSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class CreateOrderEditProductFailedEvent extends CreateOrderEvent {
  final String? failedMessage;

  const CreateOrderEditProductFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class CreateOrderGetPaperFluteEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrderGetPaperFluteLoadingEvent extends CreateOrderEvent {
  final bool isLoading;

  const CreateOrderGetPaperFluteLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class CreateOrderGetPaperFluteSuccessEvent extends CreateOrderEvent {
  final get_paper_flute.Data paperFluteList;
  final String? successMessage;

  const CreateOrderGetPaperFluteSuccessEvent({required this.paperFluteList, this.successMessage});

  @override
  List<Object?> get props => [paperFluteList, successMessage];
}

class CreateOrderGetPaperFluteFailedEvent extends CreateOrderEvent {
  @override
  List<Object?> get props => [];
}
