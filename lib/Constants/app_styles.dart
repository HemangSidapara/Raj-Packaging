import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppStyles {
  static TextStyle get size14W600TextStyle => TextStyle(
        color: AppColors.PRIMARY_COLOR,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get size16W600TextStyle => TextStyle(
        color: AppColors.PRIMARY_COLOR,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get size18W600TextStyle => TextStyle(
        color: AppColors.PRIMARY_COLOR,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );
}
