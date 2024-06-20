import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const LoadingWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAssets.splashAnim,
      height: height ?? 10.h,
      width: width ?? 10.h,
    );
  }
}
