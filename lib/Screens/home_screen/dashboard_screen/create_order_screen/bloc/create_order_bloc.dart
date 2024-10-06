import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/orders_models/get_orders_model.dart' as get_orders;
import 'package:raj_packaging/Network/services/create_order_services/create_order_service.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  String partyName = "";
  String phoneNumber = "";
  String productName = "";

  int orderTypeIndex = 0;
  int plySheetTypeIndex = 0;
  int boxTypeIndex = 0;
  int jointTypeIndex = -1;
  int plyBoxRSCTypeIndex = 0;
  int plyBoxDiePunchTypeIndex = 0;

  List<get_orders.Data> partyList = <get_orders.Data>[];
  String? selectedPartyId;
  bool isPartyEditEnable = false;
  List<get_orders.ProductData> productList = <get_orders.ProductData>[];
  String? selectedProductId;

  CreateOrderBloc() : super(CreateOrderInitial()) {
    on<CreateOrderStartedEvent>((event, emit) {
      add(CreateOrderGetPartiesEvent());
    });

    on<CreateOrderGetPartiesEvent>((event, emit) async {
      await getPartiesApiCall(event, emit);
    });

    on<CreateOrderEditPartyClickEvent>((event, emit) async {
      await checkEditParty(event, emit);
    });

    on<CreateOrderEditPartyLoadingEvent>((event, emit) async {
      emit(CreateOrderEditPartyLoadingState(isLoading: event.isLoading));
    });

    on<CreateOrderEditPartySuccessEvent>((event, emit) async {
      emit(CreateOrderEditPartySuccessState(successMessage: event.successMessage));
    });

    on<CreateOrderEditPartyFailedEvent>((event, emit) async {
      emit(CreateOrderEditPartyFailedState(failedMessage: event.failedMessage));
    });

    on<CreateOrderSelectedPartyEvent>((event, emit) {
      selectedPartyId = event.partyId;
      productList.clear();
      productList.addAll(partyList.firstWhereOrNull((element) => element.partyId == event.partyId)?.productData ?? []);
      emit(CreateOrderSelectedPartyState(productList: productList, partyId: event.partyId));
    });

    on<CreateOrderSelectedProductEvent>((event, emit) {
      selectedProductId = event.productId;
      emit(CreateOrderSelectedProductState(productId: event.productId));
    });

    on<CreateOrderGetPartiesLoadingEvent>((event, emit) async {
      emit(CreateOrderGetPartiesLoadingState(isLoading: event.isLoading));
    });

    on<CreateOrderGetPartiesSuccessEvent>((event, emit) async {
      emit(CreateOrderGetPartiesSuccessState(partyList: event.partyList, successMessage: event.successMessage));
    });

    on<CreateOrderGetPartiesFailedEvent>((event, emit) async {
      emit(CreateOrderGetPartiesFailedState());
    });

    on<CreateOrderTypeEvent>((event, emit) {
      orderTypeIndex = event.orderTypeIndex;
      emit(CreateOrderTypeState(orderTypeIndex: event.orderTypeIndex));
    });

    on<CreateOrderPlySheetTypeEvent>((event, emit) {
      plySheetTypeIndex = event.plySheetTypeIndex;
      emit(CreateOrderPlySheetTypeState(plySheetTypeIndex: event.plySheetTypeIndex));
    });

    on<CreateOrderBoxTypeEvent>((event, emit) {
      boxTypeIndex = event.boxTypeIndex;
      emit(CreateOrderBoxTypeState(boxTypeIndex: event.boxTypeIndex));
    });

    on<CreateOrderJointTypeEvent>((event, emit) {
      jointTypeIndex = event.jointTypeIndex;
      emit(CreateOrderJointTypeState(jointTypeIndex: event.jointTypeIndex));
    });

    on<CreateOrderPlyBoxRSCTypeEvent>((event, emit) {
      plyBoxRSCTypeIndex = event.plyBoxRSCTypeIndex;
      emit(CreateOrderPlyBoxRSCTypeState(plyBoxRSCTypeIndex: event.plyBoxRSCTypeIndex));
    });

    on<CreateOrderPlyBoxDiePunchTypeEvent>((event, emit) {
      plyBoxDiePunchTypeIndex = event.plyBoxDiePunchTypeIndex;
      emit(CreateOrderPlyBoxDiePunchTypeState(plyBoxDiePunchTypeIndex: event.plyBoxDiePunchTypeIndex));
    });

    on<CreateOrderButtonClickEvent>((event, emit) async {
      await checkCreateOrder(event, emit);
    });

    on<CreateOrderLoadingEvent>((event, emit) async {
      emit(CreateOrderLoadingState(isLoading: event.isLoading));
    });

    on<CreateOrderSuccessEvent>((event, emit) async {
      emit(CreateOrderSuccessState(successMessage: event.successMessage));
    });

    on<CreateOrderFailedEvent>((event, emit) async {
      emit(CreateOrderFailedState());
    });
  }

  String? validatePartyName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPartyName;
    }
    return null;
  }

  String? validatePartyList(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectParty;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPhoneNumber;
    } else if (value.length < 10) {
      return S.current.pleaseEnterValidPhoneNumber;
    }
    return null;
  }

  String? validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterProductName;
    }
    return null;
  }

  String? validateProductList(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectProduct;
    }
    return null;
  }

  String? validateDeckleSize(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterDeckleSize;
    }
    return null;
  }

  String? validateSpecificationType(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectType;
    }
    return null;
  }

  String? validateTypeName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterType;
    }
    return null;
  }

  String? validatePly(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectPly;
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterQuantity;
    }
    return null;
  }

  String? validateProductionSize(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterProductionSize;
    }
    return null;
  }

  String? validateCuttingSize(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterDeckleSize;
    }
    return null;
  }

  String? validateUps(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterUps;
    }
    return null;
  }

  String productionQuantityCalculatorForRoll({
    required TextEditingController productionQuantityController,
    required String orderQuantity,
    required String orderSizeDeckle,
    required String productionSizeDeckle,
  }) {
    if (orderQuantity.isNotEmpty && productionSizeDeckle.isNotEmpty && orderSizeDeckle.isNotEmpty) {
      productionQuantityController.text = (orderQuantity.toDouble() / (productionSizeDeckle.toDouble() / orderSizeDeckle.toDouble())).toStringAsFixed(2).replaceAll(".00", "");
      return productionQuantityController.text;
    }

    return productionQuantityController.text;
  }

  String productionQuantityCalculatorForSheet({
    required TextEditingController productionQuantityController,
    required String orderQuantity,
    required String orderSizeDeckle,
    required String productionSizeDeckle,
    required String orderSizeCutting,
    required String productionSizeCutting,
  }) {
    if (orderQuantity.isNotEmpty && productionSizeDeckle.isNotEmpty && orderSizeDeckle.isNotEmpty && productionSizeCutting.isNotEmpty && orderSizeCutting.isNotEmpty) {
      productionQuantityController.text = (orderQuantity.toDouble() / ((productionSizeDeckle.toDouble() / orderSizeDeckle.toDouble()).truncateToDouble() * (productionSizeCutting.toDouble() / orderSizeCutting.toDouble()).truncateToDouble())).toStringAsFixed(2).replaceAll(".00", "");
      return productionQuantityController.text;
    }

    return productionQuantityController.text;
  }

  (String deckle, String cutting) actualSheetSizeCalculatorForBoxRSC({
    required TextEditingController actualSheetSizeBoxRSCDecalController,
    required TextEditingController actualSheetSizeBoxRSCCuttingController,
    required String orderSizeL,
    required String orderSizeB,
    required String orderSizeH,
  }) {
    if (orderSizeL.isNotEmpty && orderSizeB.isNotEmpty && orderSizeH.isNotEmpty) {
      actualSheetSizeBoxRSCDecalController.text = (orderSizeB.toDouble() + orderSizeH.toDouble()).toStringAsFixed(2);
      actualSheetSizeBoxRSCCuttingController.text = (((orderSizeL.toDouble() + orderSizeB.toDouble()) * 2) + 1.5).toStringAsFixed(2).replaceAll(".00", "");
      return (actualSheetSizeBoxRSCDecalController.text, actualSheetSizeBoxRSCCuttingController.text);
    }

    return ("", "");
  }

  String productionQuantityCalculatorForBox({
    required TextEditingController productionQuantityController,
    required String orderQuantity,
    required String actualSizeDeckle,
    required String productionSizeDeckle,
    required String actualSizeCutting,
    required String productionSizeCutting,
    required String? upsForDiePunch,
  }) {
    if (orderQuantity.isNotEmpty && productionSizeDeckle.isNotEmpty && actualSizeDeckle.isNotEmpty && productionSizeCutting.isNotEmpty && actualSizeCutting.isNotEmpty) {
      productionQuantityController.text = ((orderQuantity.toDouble() / ((productionSizeDeckle.toDouble() / actualSizeDeckle.toDouble()).truncateToDouble() * (productionSizeCutting.toDouble() / actualSizeCutting.toDouble()).truncateToDouble())) / (upsForDiePunch?.toDouble() ?? 1)).toStringAsFixed(2).replaceAll(".00", "");
      return productionQuantityController.text;
    }

    return productionQuantityController.text;
  }

  Future<void> getPartiesApiCall(CreateOrderGetPartiesEvent event, Emitter<CreateOrderState> emit) async {
    try {
      add(const CreateOrderGetPartiesLoadingEvent(isLoading: true));
      final response = await CreateOrderService.getPartiesService();

      if (response.isSuccess) {
        get_orders.GetOrdersModel getOrdersModel = get_orders.GetOrdersModel.fromJson(response.response?.data);
        partyList.clear();
        partyList.addAll(getOrdersModel.data ?? []);
        setData(AppConstance.localPartiesStored, getOrdersModel.toJson());
        add(CreateOrderGetPartiesSuccessEvent(partyList: getOrdersModel.data ?? [], successMessage: response.message));
      } else {
        partyList.clear();
        partyList.addAll(get_orders.GetOrdersModel.fromJson(getData(AppConstance.localPartiesStored)).data ?? []);
        add(CreateOrderGetPartiesFailedEvent());
      }
    } finally {
      add(const CreateOrderGetPartiesLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkEditParty(CreateOrderEditPartyClickEvent event, Emitter<CreateOrderState> emit) async {
    try {
      add(const CreateOrderEditPartyLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await CreateOrderService.editPartyService(
          partyId: event.partyId,
          partyName: event.partyName,
          partyPhone: event.partyPhone,
        );

        if (response.isSuccess) {
          add(CreateOrderEditPartySuccessEvent(successMessage: response.message));
        } else {
          add(CreateOrderEditPartyFailedEvent(failedMessage: response.message));
        }
      }
    } finally {
      add(const CreateOrderEditPartyLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkCreateOrder(CreateOrderButtonClickEvent event, Emitter<CreateOrderState> emit) async {
    try {
      add(const CreateOrderLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await CreateOrderService.createOrderService(
          partyId: event.partyId,
          productId: event.productId,
          partyName: event.partyName,
          partyPhone: event.partyPhone,
          orderType: event.orderType,
          boxType: event.boxType,
          productName: event.productName,
          orderQuantity: event.orderQuantity,
          productionDeckle: event.productionDeckle,
          productionCutting: event.productionCutting,
          productionQuantity: event.productionQuantity,
          deckle: event.deckle,
          cutting: event.cutting,
          ply: event.ply,
          topPaper: event.topPaper,
          paper: event.paper,
          flute: event.flute,
          l: event.l,
          b: event.b,
          h: event.h,
          ups: event.ups,
          jointType: event.jointType,
          notes: event.notes,
        );

        if (response.isSuccess) {
          add(CreateOrderSuccessEvent(successMessage: response.message));
        } else {
          add(CreateOrderFailedEvent());
        }
      }
    } finally {
      add(const CreateOrderLoadingEvent(isLoading: false));
    }
  }
}
