import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class ProductionServices {
  ///Get Production Data
  static Future<ResponseModel> getProductionService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getProductionApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getProductionApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getProductionApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
