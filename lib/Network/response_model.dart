import 'package:dio/dio.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';

class ResponseModel {
  int? statusCode;
  Response? response;

  ResponseModel({this.statusCode, this.response});

  get data => response?.data['data'];

  get message => response?.data is String ? null : response?.data['msg'];

  bool get isSuccess => response != null && response!.statusCode! >= 200 && response!.statusCode! <= 299 && (response?.data['code'] != null ? response!.data['code'].toString().toInt() >= 200 && response!.data['code'].toString().toInt() <= 299 : true);

  getExtraData(String paramName) {
    return response?.data[paramName];
  }
}
