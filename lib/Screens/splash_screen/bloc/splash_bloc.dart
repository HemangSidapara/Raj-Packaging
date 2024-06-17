import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  String _currentVersion = "";
  String _newAPKVersion = "";
  String _newAPKUrl = "";
  int _downloadedProgress = 0;

  final _newAPKUrlController = StreamController<String?>.broadcast();

  Stream<String?> get newAPKUrlStream => _newAPKUrlController.stream;

  final _downloadedProgressController = StreamController<int>.broadcast();

  Stream<int> get downloadedProgressStream => _downloadedProgressController.stream;

  void setNewAPKUrl(String? url) {
    _newAPKUrlController.add(url);
    _newAPKUrl = url ?? "";
  }

  void setDownloadedProgress(int progress) {
    _downloadedProgressController.add(progress);
    _downloadedProgress = progress;
  }

  Stopwatch stopwatch = Stopwatch();

  SplashBloc() : super(SplashInitialState()) {
    on<SplashStartedEvent>((event, emit) async {
      stopwatch.start();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarIconBrightness: Brightness.light,
      ));

      newAPKUrlStream.listen((event) async {
        _currentVersion = (await GetPackageInfoService.instance.getInfo()).version;
        add(SplashGetCurrentVersionEvent());
        debugPrint('currentVersion :: $_currentVersion');
        debugPrint('newVersion :: $_newAPKVersion');
        stopwatch.stop();
        if (event?.isNotEmpty == true && _newAPKVersion.isNotEmpty) {
          if (Utils.isUpdateAvailable(_currentVersion, _newAPKVersion)) {
            add(SplashUpdateAvailableEvent());
          } else {
            await Future.delayed(
              Duration(milliseconds: 3000 - stopwatch.elapsedMilliseconds),
              () async {
                await nextScreenRoute(emit);
              },
            );
          }
        } else {
          await Future.delayed(
            Duration(milliseconds: 3000 - stopwatch.elapsedMilliseconds),
            () async {
              await nextScreenRoute(emit);
            },
          );
        }
      });

      await _getLatestVersion();
    });

    on<SplashGetCurrentVersionEvent>((event, emit) async {
      emit(SplashCurrentVersionState(currentVersion: _currentVersion));
    });

    on<SplashUpdateAvailableEvent>((event, emit) {
      emit(SplashOnUpdateAvailableState());
    });

    on<SplashDownloadAndInstallStartEvent>((event, emit) async {
      await _downloadAndInstall(emit);
    });

    on<SplashDownloadAndInstallInProgressEvent>((event, emit) async {
      emit(SplashUpdateProgressState(isUpdateLoading: event.isUpdateLoading, downloadedProgress: event.downloadedProgress));
    });

    on<SplashAuthorizedEvent>((event, emit) async {
      emit(SplashAuthorizedState());
    });

    on<SplashUnauthorizedEvent>((event, emit) async {
      emit(SplashUnauthorizedState());
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
      add(SplashUnauthorizedEvent());
    } else {
      add(SplashAuthorizedEvent());
    }
  }

  /// Get latest Version on server
  Future<void> _getLatestVersion() async {
    final response = await AuthServices.getLatestVersionService();
    if (response.isSuccess) {
      GetLatestVersionModel versionModel = GetLatestVersionModel.fromJson(response.response?.data);
      setNewAPKUrl(versionModel.data?.firstOrNull?.appUrl ?? "");
      _newAPKVersion = versionModel.data?.firstOrNull?.appVersion ?? "";
    } else {
      setNewAPKUrl("");
      _newAPKVersion = "";
    }
  }

  /// Download and install
  Future<void> _downloadAndInstall(Emitter<SplashState> emit) async {
    try {
      emit(SplashUpdateProgressState(isUpdateLoading: true, downloadedProgress: _downloadedProgress));
      downloadedProgressStream.listen(
        (event) {
          add(SplashDownloadAndInstallInProgressEvent(isUpdateLoading: true, downloadedProgress: event));
        },
      );
      final directory = await getExternalStorageDirectory();
      final downloadPath = '${directory?.path}/app-release.apk';

      if (_newAPKUrl.isNotEmpty) {
        final response = await Dio().downloadUri(
          Uri.parse(_newAPKUrl),
          downloadPath,
          onReceiveProgress: (counter, total) {
            if (total != -1) {
              debugPrint("Downloaded % :: ${(counter / total * 100).toStringAsFixed(0)}%");
              setDownloadedProgress((counter / total * 100).toStringAsFixed(0).toInt());
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
      emit(SplashUpdateProgressState(isUpdateLoading: false, downloadedProgress: _downloadedProgress));
    }
  }

  @override
  Future<void> close() {
    _newAPKUrlController.close();
    _downloadedProgressController.close();
    return super.close();
  }
}
