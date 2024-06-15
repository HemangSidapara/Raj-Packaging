import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';

// ignore: must_be_immutable
class LoadingProgressBar extends StatelessWidget {
  Color? color = Colors.white;
  Color? indicatorColor;
  double? width = 5.0;
  double? height = 5.0;
  bool isDismissible = false;
  double? value;

  LoadingProgressBar({
    super.key,
    this.color,
    this.width,
    this.height,
    required this.isDismissible,
    this.indicatorColor,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isDismissible,
      child: Container(
        color: color,
        width: width,
        height: height,
        child: CircularProgressIndicator(
          color: indicatorColor ?? AppColors.PRIMARY_COLOR,
          value: value,
          semanticsValue: value.toString(),
        ),
      ),
    );
  }
}
