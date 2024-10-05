import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class CreateOrderService {
  ///Get Parties
  static Future<ResponseModel> getPartiesService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getPartiesApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getPartiesApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getPartiesApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  ///Create Order Service
  static Future<ResponseModel> createOrderService({
    String? partyId,
    String? productId,
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
    String? ups,
    String? jointType,
    String? notes,
  }) async {
    final params = {
      ApiKeys.partyId: partyId,
      ApiKeys.productId: productId,
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
      ApiKeys.ups: ups,
      ApiKeys.joint: jointType,
      ApiKeys.notes: notes,
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
          if (kDebugMode) {
            print("createOrderApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("createOrderApi error :: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Edit Party Service
  static Future<ResponseModel> editPartyService({
    required String partyId,
    required String partyName,
    required String partyPhone,
  }) async {
    final params = {
      ApiKeys.partyId: partyId,
      ApiKeys.partyName: partyName,
      ApiKeys.partyPhone: partyPhone,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.editPartyApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("editPartyApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("editPartyApi error :: ${res.message}");
          }
        }
      },
    );

    return response;
  }
}
