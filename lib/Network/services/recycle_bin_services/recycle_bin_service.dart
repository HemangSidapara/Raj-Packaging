import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class RecycleBinService {
  /// Get Recycle Bin Orders
  static Future<ResponseModel> getRecycleBinOrderService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getArchivedOrdersApi,
      showProgress: false,
      options: Options(
        sendTimeout: Duration.zero,
        receiveTimeout: Duration.zero,
      ),
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getArchivedOrdersApi success :: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getArchivedOrdersApi error :: ${res.message}");
          }
        }
      },
    );
    return response;
  }
}
