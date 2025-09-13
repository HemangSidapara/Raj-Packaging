import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class PendingOrdersService {
  ///Get Orders
  static Future<ResponseModel> getOrdersService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getOrdersApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getOrdersApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getOrdersApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  ///Delete Order Service
  static Future<ResponseModel> deleteOrderService({
    required String orderId,
  }) async {
    final response = await ApiBaseHelper.deleteHTTP(
      ApiUrls.deleteOrderApi + orderId,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("deleteOrderApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("deleteOrderApi error :: ${res.message}");
          }
        }
      },
    );

    return response;
  }

  ///Create Job Service
  static Future<ResponseModel> createJobService({
    required String partyId,
    required String productId,
    required String orderId,
    required int branch,
  }) async {
    final params = {
      ApiKeys.partyId: partyId,
      ApiKeys.productId: productId,
      ApiKeys.orderId: orderId,
      ApiKeys.branch: branch,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.createJobApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("createJobApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("createJobApi error :: ${res.message}");
          }
        }
      },
    );

    return response;
  }
}
