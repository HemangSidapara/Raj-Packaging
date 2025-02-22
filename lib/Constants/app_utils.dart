import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';
import 'package:raj_packaging/Widgets/custom_snack_bar_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Utils {
  static BuildContext? context;

  static void setGlobalContext(BuildContext value) => context = value;

  static BuildContext? get getGlobalContext => context;

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
    BuildContext? context,
    String? message,
    bool isError = false,
    bool isWarning = false,
    Color? barColor,
    Color? iconColor,
    Color? textColor,
  }) {
    context ??= getGlobalContext!;
    message ??= 'Empty message';
    TextStyle textStyle = TextStyle(
      fontSize: 15.sp,
      color: textColor ?? AppColors.WHITE_COLOR,
      fontWeight: FontWeight.w600,
    );
    EdgeInsetsGeometry messagePadding = EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h);
    int maxLines = 1000;
    Color backgroundColor = barColor ??
        (isError
            ? AppColors.ERROR_COLOR
            : isWarning
                ? AppColors.WARNING_COLOR
                : AppColors.SUCCESS_COLOR);

    showTopSnackBar(
      Overlay.of(context),
      snackBarPosition: SnackBarPosition.bottom,
      isError
          ? CustomSnackBarWidget.error(
              message: message,
              textStyle: textStyle,
              messagePadding: messagePadding,
              maxLines: maxLines,
              backgroundColor: backgroundColor,
            )
          : isWarning
              ? CustomSnackBarWidget.info(
                  message: message,
                  textStyle: textStyle,
                  messagePadding: messagePadding,
                  maxLines: maxLines,
                  backgroundColor: backgroundColor,
                )
              : CustomSnackBarWidget.success(
                  message: message,
                  textStyle: textStyle,
                  messagePadding: messagePadding,
                  maxLines: maxLines,
                  backgroundColor: backgroundColor,
                ),
    );
  }
}
