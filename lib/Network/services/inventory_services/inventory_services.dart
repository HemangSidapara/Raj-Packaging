import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class InventoryServices {
  ///Get Inventory Service
  static Future<ResponseModel> getProductionService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getInventoryApi,
      showProgress: false,
      onError: (res) {
        if (kDebugMode) {
          print("getInventoryApi Error ::: ${res.message}");
        }
        Utils.handleMessage(message: res.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getInventoryApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getInventoryApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
