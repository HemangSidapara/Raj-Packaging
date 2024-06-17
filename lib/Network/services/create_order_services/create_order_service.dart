import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class CreateOrderService {
  ///Create Order Service
  static Future<ResponseModel> loginService({
    required String partyName,
    required String partyPhone,
    required String orderType,
    String? boxType,
    required String productName,
    required String orderQuantity,
    required String productionDeckle,
    String? productionCutting,
    required String productionQuantity,
    required String deckle,
    String? cutting,
    String? ply,
    String? topPaper,
    String? paper,
    String? flute,
    String? l,
    String? b,
    String? h,
  }) async {
    final params = {
      ApiKeys.partyName: partyName,
      ApiKeys.partyPhone: partyPhone,
      ApiKeys.orderType: orderType,
      ApiKeys.boxType: boxType,
      ApiKeys.productName: productName,
      ApiKeys.orderQuantity: orderQuantity,
      ApiKeys.productionDeckle: productionDeckle,
      ApiKeys.productionCutting: productionCutting,
      ApiKeys.productionQuantity: productionQuantity,
      ApiKeys.deckle: deckle,
      ApiKeys.cutting: cutting,
      ApiKeys.ply: ply,
      ApiKeys.topPaper: topPaper,
      ApiKeys.paper: paper,
      ApiKeys.flute: flute,
      ApiKeys.l: l,
      ApiKeys.b: b,
      ApiKeys.h: h,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.createOrderApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("createOrderApi success :: ${res.message}");
        } else {
          debugPrint("createOrderApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}