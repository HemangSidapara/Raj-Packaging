import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class CompletedOrderService {
  /// Get Completed Orders
  static Future<ResponseModel> getCompletedOrderService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getCompletedOrdersApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getCompletedOrdersApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getCompletedOrdersApi error :: ${res.message}");
          }
        }
      },
    );
    return response;
  }

  /// Edit Quantity
  static Future<ResponseModel> editQuantityService({
    required String orderId,
    required String orderQuantity,
  }) async {
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.editOrderQuantityApi,
      showProgress: false,
      params: {
        ApiKeys.orderId: orderId,
        ApiKeys.orderQuantity: orderQuantity,
      },
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("editOrderQuantityApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("editOrderQuantityApi error :: ${res.message}");
          }
        }
      },
    );
    return response;
  }

  /// Archive Order
  static Future<ResponseModel> archiveOrderService({required String orderId}) async {
    final response = await ApiBaseHelper.getHTTP(
      "${ApiUrls.archiveOrdersApi}$orderId",
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("archiveOrdersApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("archiveOrdersApi error :: ${res.message}");
          }
        }
      },
    );
    return response;
  }
}
