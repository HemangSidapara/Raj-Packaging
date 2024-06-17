import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  int orderTypeIndex = 0;
  int plyTypeIndex = 0;
  int boxTypeIndex = 0;

  CreateOrderBloc() : super(CreateOrderInitial()) {
    on<CreateOrderStartedEvent>((event, emit) {});

    on<CreateOrderTypeEvent>((event, emit) {
      orderTypeIndex = event.orderTypeIndex;
      emit(CreateOrderTypeState(orderTypeIndex: event.orderTypeIndex));
    });

    on<CreateOrderPlyTypeEvent>((event, emit) {
      plyTypeIndex = event.plyTypeIndex;
      emit(CreateOrderPlyTypeState(plyTypeIndex: event.plyTypeIndex));
    });

    on<CreateOrderBoxTypeEvent>((event, emit) {
      boxTypeIndex = event.boxTypeIndex;
      emit(CreateOrderBoxTypeState(boxTypeIndex: event.boxTypeIndex));
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

  String productionQuantityCalculatorForRoll({
    required TextEditingController productionQuantityController,
    required String orderQuantity,
    required String orderSizeDeckle,
    required String productionSizeDeckle,
  }) {
    if (orderQuantity.isNotEmpty && productionSizeDeckle.isNotEmpty && orderSizeDeckle.isNotEmpty) {
      productionQuantityController.text = (orderQuantity.toDouble() / (productionSizeDeckle.toDouble() / orderSizeDeckle.toDouble())).toStringAsFixed(2);
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
      productionQuantityController.text = (orderQuantity.toDouble() / ((productionSizeDeckle.toDouble() / orderSizeDeckle.toDouble()) * (productionSizeCutting.toDouble() / orderSizeCutting.toDouble()))).toStringAsFixed(2);
      return productionQuantityController.text;
    }

    return productionQuantityController.text;
  }
}
