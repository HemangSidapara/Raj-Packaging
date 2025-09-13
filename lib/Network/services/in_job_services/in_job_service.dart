import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class InJobService {
  ///Get Jobs
  static Future<ResponseModel> getJobsService({required int branch,}) async {
    final response = await ApiBaseHelper.getHTTP(
      "${ApiUrls.getJobApi}$branch",
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getJobApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getJobApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  ///Delete Jobs
  static Future<ResponseModel> deleteJobsService({required String orderId}) async {
    final response = await ApiBaseHelper.deleteHTTP(
      ApiUrls.deleteJobsApi + orderId,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("deleteJobsApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("deleteJobsApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
