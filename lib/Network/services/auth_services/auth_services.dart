import 'package:flutter/cupertino.dart';
import 'package:raj_packaging/Constants/api_keys.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/api_base_helper.dart';
import 'package:raj_packaging/Network/models/auth_models/get_latest_version_model.dart';
import 'package:raj_packaging/Network/models/auth_models/login_model.dart';
import 'package:raj_packaging/Network/response_model.dart';

class AuthServices {
  ///Get Latest Version Service
  static Future<ResponseModel> getLatestVersionService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.inAppUpdateApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          GetLatestVersionModel latestVersionModel = GetLatestVersionModel.fromJson(res.response?.data);
          debugPrint("inAppUpdateApi success :: ${latestVersionModel.msg}");
        } else {
          debugPrint("inAppUpdateApi error :: ${res.message}");
        }
      },
    );

    return response;
  }

  ///Login Service
  static Future<ResponseModel> loginService({
    required String phone,
    required String password,
  }) async {
    final params = {
      ApiKeys.phone: phone,
      ApiKeys.password: password,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.loginApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          LoginModel loginModel = LoginModel.fromJson(res.response?.data);
          await setData(AppConstance.authorizationToken, loginModel.token);
          await setData(AppConstance.role, loginModel.role);
          debugPrint("loginApi success :: ${loginModel.msg}");
          Utils.handleMessage(message: loginModel.msg);
        } else {
          debugPrint("loginApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
