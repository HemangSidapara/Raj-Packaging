import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/auth_models/get_latest_version_model.dart';
import 'package:raj_packaging/Network/services/auth_services/auth_services.dart';
import 'package:raj_packaging/Network/services/utils_services/get_package_info_service.dart';
import 'package:raj_packaging/Network/services/utils_services/install_apk_service.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  bool isUpdateLoading = false;
  int downloadedProgress = 0;
  String currentVersion = "";
  String _newAPKVersion = "";
  String _newAPKUrl = "";

  final _newAPKUrlController = StreamController<String?>.broadcast();

  Stream<String?> get newAPKUrlStream => _newAPKUrlController.stream;

  void setNewAPKUrl(String? url) {
    _newAPKUrlController.add(url);
    _newAPKUrl = url ?? "";
  }

  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarIconBrightness: Brightness.light,
      ));

      newAPKUrlStream.listen((event) async {
        currentVersion = (await GetPackageInfoService.instance.getInfo()).version;
        add(SplashGetCurrentVersion());
        debugPrint('currentVersion :: $currentVersion');
        debugPrint('newVersion :: $_newAPKVersion');
        if (event?.isNotEmpty == true && _newAPKVersion.isNotEmpty) {
          if (Utils.isUpdateAvailable(currentVersion, _newAPKVersion)) {
            add(SplashUpdateAvailable());
          } else {
            await nextScreenRoute(emit);
          }
        } else {
          await nextScreenRoute(emit);
        }
      });

      await _getLatestVersion();
    });

    on<SplashGetCurrentVersion>((event, emit) {
      emit(SplashCurrentVersion());
    });

    on<SplashUpdateAvailable>((event, emit) {
      emit(SplashOnUpdateAvailable());
    });

    on<SplashDownloadAndInstall>((event, emit) async {
      await _downloadAndInstall(emit);
    });
  }

  /// Next Screen Route
  Future<void> nextScreenRoute(Emitter<SplashState> emit) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.TRANSPARENT,
        statusBarBrightness: Brightness.light,
      ),
    );
    debugPrint("token value ::: ${getData(AppConstance.authorizationToken)}");
    if (getData(AppConstance.authorizationToken) == null) {
      emit(SplashUnauthorized());
    } else {
      emit(SplashAuthorized());
    }
  }

  /// Get latest Version on server
  Future<void> _getLatestVersion() async {
    final response = await AuthServices.getLatestVersionService();
    GetLatestVersionModel versionModel = GetLatestVersionModel.fromJson(response.response?.data);
    if (response.isSuccess) {
      setNewAPKUrl(versionModel.data?.firstOrNull?.appUrl ?? "");
      _newAPKVersion = versionModel.data?.firstOrNull?.appVersion ?? "";
    }
  }

  /// Download and install
  Future<void> _downloadAndInstall(Emitter<SplashState> emit) async {
    try {
      emit(const SplashUpdateProgress(isUpdateLoading: true, downloadedProgress: 0));
      final directory = await getExternalStorageDirectory();
      final downloadPath = '${directory?.path}/app-release.apk';

      if (_newAPKUrl.isNotEmpty) {
        final response = await Dio().downloadUri(
          Uri.parse(_newAPKUrl),
          downloadPath,
          onReceiveProgress: (counter, total) {
            if (total != -1) {
              debugPrint("Downloaded % :: ${(counter / total * 100).toStringAsFixed(0)}%");
              downloadedProgress = (counter / total * 100).toStringAsFixed(0).toInt();
              emit(SplashUpdateProgress(
                isUpdateLoading: true,
                downloadedProgress: downloadedProgress,
              ));
            }
          },
        );

        if (response.statusCode == 200) {
          File file = File(downloadPath);
          if (await file.exists()) {
            await InstallApkService.instance.installApk();
            Utils.handleMessage(message: 'Downloaded successfully!');
          } else {
            Utils.handleMessage(message: 'Downloaded file not found.', isError: true);
          }
        } else {
          Utils.handleMessage(message: 'Failed to update.', isError: true);
        }
      } else {
        Utils.handleMessage(message: 'Failed to download.', isError: true);
      }
    } finally {
      emit(const SplashUpdateProgress(isUpdateLoading: false, downloadedProgress: 100));
    }
  }
}
