import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:raj_packaging/Constants/api_urls.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/response_model.dart';
import 'package:raj_packaging/Utils/utils.dart';

class ApiBaseHelper {
  static const String baseUrl = ApiUrls.baseUrl;
  static bool showProgressDialog = true;
  static Stopwatch stopWatch = Stopwatch();

  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 45),
    receiveTimeout: const Duration(seconds: 45),
    sendTimeout: const Duration(seconds: 45),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    ///For Print Logs
    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          error: true,
          responseHeader: true,
        ),
      );
    }

    ///For Show Hide Progress Dialog
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
            return requestInterceptor(options, handler);
          },
          onResponse: (response, handler) async {
            showProgressDialog = true;

            if (response.statusCode! >= 100 && response.statusCode! <= 199) {
              Logger.printLog(tag: 'WARNING CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.warning);
            } else {
              Logger.printLog(tag: 'SUCCESS CODE ${response.statusCode} : ', printLog: response.data.toString(), logIcon: Logger.success);
            }

            return handler.next(response);
          },
          onError: (DioException e, handler) async {
            showProgressDialog = true;

            Logger.printLog(tag: 'ERROR CODE ${e.response?.statusCode} : ', printLog: e.toString(), logIcon: Logger.error);

            return handler.next(e);
          },
        ),
      );
  }

  static dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      "Authorization": "Bearer ${getData(AppConstance.authorizationToken)}",
      "content-type": "application/json",
    });

    Logger.printLog(tag: '|---------------> ${options.method} JSON METHOD <---------------|\n\n REQUEST_URL :', printLog: '\n ${options.uri} \n\n REQUEST_HEADER : ${options.headers}  \n\n REQUEST_DATA : ${options.data.toString()}', logIcon: Logger.info);

    return handler.next(options);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  static Future<ResponseModel> postHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      showProgressDialog = showProgress;
      stopWatch.start();
      Response response = await baseAPI.post(
        url,
        data: params,
        onSendProgress: onSendProgress,
      );
      stopWatch.stop();
      Logger.printLog(isTimer: true, printLog: stopWatch.elapsed.inMilliseconds / 1000);
      stopWatch.reset();
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  static Future<ResponseModel> deleteHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      stopWatch.start();
      Response response = await baseAPI.delete(
        url,
        data: params,
      );
      stopWatch.stop();
      Logger.printLog(isTimer: true, printLog: stopWatch.elapsed.inMilliseconds / 1000);
      stopWatch.reset();
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  static Future<ResponseModel> getHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    Options? options,
  }) async {
    try {
      showProgressDialog = showProgress;
      stopWatch.start();
      Response response = await baseAPI.get(
        url,
        queryParameters: params,
        options: options,
      );
      stopWatch.stop();
      Logger.printLog(isTimer: true, printLog: stopWatch.elapsed.inMilliseconds / 1000);
      stopWatch.reset();
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  static Future<ResponseModel> putHTTP(
    String url, {
    dynamic data,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
  }) async {
    try {
      showProgressDialog = showProgress;
      stopWatch.start();
      Response response = await baseAPI.put(url, data: data);
      stopWatch.stop();
      Logger.printLog(isTimer: true, printLog: stopWatch.elapsed.inMilliseconds / 1000);
      stopWatch.reset();
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  static Future<ResponseModel> patchHTTP(
    String url, {
    dynamic params,
    bool showProgress = true,
    Function(ResponseModel res)? onSuccess,
    Function(DioExceptions dioExceptions)? onError,
    void Function(int count, int total)? onSendProgress,
  }) async {
    try {
      showProgressDialog = showProgress;
      stopWatch.start();
      Response response = await baseAPI.patch(
        url,
        data: params,
        onSendProgress: onSendProgress,
      );
      stopWatch.stop();
      Logger.printLog(isTimer: true, printLog: stopWatch.elapsed.inMilliseconds / 1000);
      stopWatch.reset();
      return handleResponse(response, onError!, onSuccess!);
    } on DioException catch (e) {
      return handleError(e, onError!, onSuccess!);
    }
  }

  static ResponseModel handleResponse(Response response, Function(DioExceptions dioExceptions) onError, Function(ResponseModel res) onSuccess) {
    var successModel = ResponseModel(statusCode: response.statusCode, response: response);
    onSuccess(successModel);
    return successModel;
  }

  static ResponseModel handleError(DioException e, Function(DioExceptions dioExceptions) onError, Function(ResponseModel res) onSuccess) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        var errorModel = ResponseModel(statusCode: e.response!.statusCode, response: e.response);
        onSuccess(errorModel);
        return ResponseModel(statusCode: e.response!.statusCode, response: e.response);
      default:
        onError(DioExceptions.fromDioError(e));
        return ResponseModel(statusCode: e.response?.statusCode, response: e.response);
    }
  }
}

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioException? dioError) {
    switch (dioError!.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "No internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleResponseError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioException.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleResponseError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal Server Error. Please try again.';
      default:
        return 'Sorry, something went wrong. Please try again.';
    }
  }
}
