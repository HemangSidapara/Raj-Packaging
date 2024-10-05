import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class JobDataService {
  ///Get Job Data
  static Future<ResponseModel> getJobDataService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getJobDataApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("getJobDataApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("getJobDataApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  ///Complete Job
  static Future<ResponseModel> completeJobService({required String jobId}) async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.completeJobApi + jobId,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("completeJobApi Success ::: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("completeJobApi Error ::: ${res.message}");
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
