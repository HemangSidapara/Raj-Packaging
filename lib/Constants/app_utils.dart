import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';
import 'package:raj_packaging/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Utils {
  ///Unfocus
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Current app is latest or not
  static bool isUpdateAvailable(String currentVersion, String newAPKVersion) {
    List<String> versionNumberList = currentVersion.split('.').toList();
    List<String> storeVersionNumberList = newAPKVersion.split('.').toList();
    for (int i = 0; i < versionNumberList.length; i++) {
      if (versionNumberList[i].toInt() != storeVersionNumberList[i].toInt()) {
        if (versionNumberList[i].toInt() < storeVersionNumberList[i].toInt()) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  ///showSnackBar
  static void handleMessage({
    String? message,
    bool isError = false,
    bool isWarning = false,
    Color? barColor,
    Color? iconColor,
    Color? textColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: barColor ??
          (isError
              ? AppColors.ERROR_COLOR
              : isWarning
                  ? AppColors.WARNING_COLOR
                  : AppColors.SUCCESS_COLOR),
      duration: const Duration(milliseconds: 2500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      content: Row(
        children: [
          Icon(
            isError
                ? Icons.error_rounded
                : isWarning
                    ? Icons.warning_rounded
                    : Icons.check_circle_rounded,
            color: iconColor ?? AppColors.WHITE_COLOR,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              message ?? 'Empty message',
              style: TextStyle(
                fontSize: 15.sp,
                color: textColor ?? AppColors.WHITE_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
