import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/models/auth_models/get_latest_version_model.dart';
import 'package:raj_packaging/Network/services/auth_services/auth_services.dart';
import 'package:raj_packaging/Network/services/utils_services/get_package_info_service.dart';
import 'package:raj_packaging/Network/services/utils_services/install_apk_service.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/dashboard_view.dart';
import 'package:raj_packaging/Screens/home_screen/recycle_bin_screen/recycle_bin_view.dart';
import 'package:raj_packaging/Screens/home_screen/settings_screen/settings_view.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PageController pageController = PageController(initialPage: 0);

  int bottomIndex = 0;
  List<String> listOfImages = [
    AppAssets.homeIcon,
    AppAssets.recycleBinIcon,
    AppAssets.settingsIcon,
  ];

  List<Widget> bottomItemWidgetList = [
    const DashboardView(),
    const RecycleBinView(),
    const SettingsView(),
  ];

  bool isUpdateLoading = false;
  int _downloadedProgress = 0;

  final _downloadedProgressController = StreamController<int>.broadcast();

  Stream<int> get downloadedProgressStream => _downloadedProgressController.stream;

  void setDownloadedProgress(int progress) {
    _downloadedProgressController.add(progress);
    _downloadedProgress = progress;
  }

  HomeBloc() : super(HomeInitial()) {
    on<HomeStartedEvent>((event, emit) {
      emit(const HomeChangeBottomIndexState(bottomIndex: 0));
    });

    on<HomeChangeBottomIndexEvent>((event, emit) async {
      await onChangeBottomIndex(event, emit);
    });

    on<HomeUpdateAvailableEvent>((event, emit) {
      emit(HomeOnUpdateAvailableState(
        isLatestVersionAvailable: event.isLatestVersionAvailable,
        newAPKUrl: event.newAPKUrl,
        newAPKVersion: event.newAPKVersion,
      ));
    });

    on<HomeDownloadAndInstallStartEvent>((event, emit) async {
      await _downloadAndInstall(event, emit);
    });

    on<HomeDownloadAndInstallInProgressEvent>((event, emit) async {
      emit(HomeUpdateProgressState(isUpdateLoading: event.isUpdateLoading, downloadedProgress: event.downloadedProgress));
    });
  }

  Future<void> onChangeBottomIndex(HomeChangeBottomIndexEvent event, Emitter<HomeState> emit) async {
    emit(HomeChangeBottomIndexState(bottomIndex: event.bottomIndex));
    bottomIndex = event.bottomIndex;
    AuthServices.getLatestVersionService().then((response) async {
      if (response.isSuccess) {
        GetLatestVersionModel versionModel = GetLatestVersionModel.fromJson(response.response?.data);
        String newAPKUrl = versionModel.data?.firstOrNull?.appUrl ?? '';
        String newAPKVersion = versionModel.data?.firstOrNull?.appVersion ?? '';
        final currentVersion = (await GetPackageInfoService.instance.getInfo()).version;
        if (kDebugMode) {
          print('currentVersion :: $currentVersion');
          print('newVersion :: $newAPKVersion');
        }
        add(HomeUpdateAvailableEvent(
          isLatestVersionAvailable: Utils.isUpdateAvailable(currentVersion, versionModel.data?.firstOrNull?.appVersion ?? currentVersion),
          newAPKVersion: newAPKVersion,
          newAPKUrl: newAPKUrl,
        ));
      }
    });
    if (event.bottomIndex == 0) {
    } else if (event.bottomIndex == 1) {}
    pageController.jumpToPage(event.bottomIndex);
  }

  /// Download and install
  Future<void> _downloadAndInstall(HomeDownloadAndInstallStartEvent event, Emitter<HomeState> emit) async {
    final currentSate = state;
    if (currentSate is HomeOnUpdateAvailableState) {
      try {
        emit(HomeUpdateProgressState(isUpdateLoading: true, downloadedProgress: _downloadedProgress));
        downloadedProgressStream.listen(
          (event) {
            add(HomeDownloadAndInstallInProgressEvent(isUpdateLoading: true, downloadedProgress: event));
          },
        );
        final directory = await getExternalStorageDirectory();
        final downloadPath = '${directory?.path}/app-release.apk';

        if (currentSate.newAPKUrl.isNotEmpty) {
          final response = await Dio().downloadUri(
            Uri.parse(currentSate.newAPKUrl),
            downloadPath,
            onReceiveProgress: (counter, total) {
              if (total != -1) {
                if (kDebugMode) {
                  print("Downloaded % :: ${(counter / total * 100).toStringAsFixed(0)}%");
                }
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
        emit(HomeUpdateProgressState(isUpdateLoading: false, downloadedProgress: _downloadedProgress));
      }
    }
  }
}
