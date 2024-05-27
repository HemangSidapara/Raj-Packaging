import 'package:dio/dio.dart';
import 'package:raj_packaging/Utils/app_formatter.dart';

class ResponseModel {
  int? statusCode;
  Response? response;

  ResponseModel({this.statusCode, this.response});

  get data => response?.data['data'];

  get message => response?.data['msg'];

  bool get isSuccess => response != null && response!.statusCode! >= 200 && response!.statusCode! <= 299 && response!.data['code'].toString().toInt() >= 200 && response!.data['code'].toString().toInt() <= 299;

  getExtraData(String paramName) {
    return response?.data[paramName];
  }
}
