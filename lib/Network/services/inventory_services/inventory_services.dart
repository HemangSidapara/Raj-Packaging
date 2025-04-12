import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
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

  ///Create Entry Service
  static Future<ResponseModel> createEntryService({
    required String entryType,
    required String itemType,
    required String size,
    required String gsm,
    required String bf,
    required String shade,
    required String weight,
    required String quantity,
  }) async {
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.createInventoryEntryApi,
      showProgress: false,
      params: {
        ApiKeys.entryType: entryType,
        ApiKeys.itemType: itemType,
        ApiKeys.size: size,
        ApiKeys.gsm: gsm,
        ApiKeys.bf: bf,
        ApiKeys.shade: shade,
        ApiKeys.weight: weight,
        ApiKeys.quantity: quantity,
      },
      onError: (res) {
        if (kDebugMode) {
          print("createInventoryEntryApi Error ::: ${res.message}");
        }
        Utils.handleMessage(message: res.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("createInventoryEntryApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("createInventoryEntryApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
