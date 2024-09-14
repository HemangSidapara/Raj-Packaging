import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/response_model.dart';

class InJobService {
  ///Get Jobs
  static Future<ResponseModel> getJobsService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getJobApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("getJobApi Success ::: ${res.message}");
        } else {
          debugPrint("getJobApi Error ::: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
