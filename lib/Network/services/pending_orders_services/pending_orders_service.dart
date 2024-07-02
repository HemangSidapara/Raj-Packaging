import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class PendingOrdersService {
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
          debugPrint("deleteOrderApi success :: ${res.message}");
        } else {
          debugPrint("deleteOrderApi error :: ${res.message}");
        }
      },
    );

    return response;
  }
}
