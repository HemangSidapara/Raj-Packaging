import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/auth_models/get_latest_version_model.dart';
import 'package:raj_packaging/Network/services/auth_services/auth_services.dart';
import 'package:raj_packaging/Network/services/utils_services/get_package_info_service.dart';
import 'package:raj_packaging/Utils/in_app_update_dialog_widget.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  bool isUpdateLoading = false;
  int downloadedProgress = 0;
  String currentVersion = "";

  final _newAPKUrlController = StreamController<String?>.broadcast();
  final _newAPKVersionController = StreamController<String?>.broadcast();

  Stream<String?> get newAPKUrlStream => _newAPKUrlController.stream;

  Stream<String?> get newAPKVersionStream => _newAPKVersionController.stream;

  void setNewAPKUrl(String? url) {
    _newAPKUrlController.sink.add(url);
  }

  void setNewAPKVersion(String? version) {
    _newAPKVersionController.sink.add(version);
  }

  void dispose() {
    _newAPKUrlController.close();
    _newAPKVersionController.close();
  }

  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarIconBrightness: Brightness.light,
      ));

      await _getLatestVersion();

      newAPKUrlStream.listen(
        (event) async {
          currentVersion = (await GetPackageInfoService.instance.getInfo()).version;
          String newAPKVersion = (await newAPKVersionStream.single) ?? "";
          debugPrint('currentVersion :: $currentVersion');
          debugPrint('newVersion :: $newAPKVersion');
          if (event?.isNotEmpty == true && newAPKVersion.isNotEmpty) {
            if (Utils.isUpdateAvailable(currentVersion, newAPKVersion)) {
              await showUpdateDialog(
                onUpdate: () async {
                  // await _downloadAndInstall();
                },
              );
            } else {
              nextScreenRoute(emit);
            }
          } else {
            nextScreenRoute(emit);
          }
        },
      );
      await Future.delayed(
        const Duration(seconds: 5),
        () {
          emit(SplashAuthorized());
        },
      );
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
      emit(SplashAuthorized());
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
      setNewAPKVersion(versionModel.data?.firstOrNull?.appVersion ?? "");
    }
  }
}
