import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String buttonTitle;
  final Color? buttonTitleColor;
  final Size? fixedSize;
  final OutlinedBorder? shape;
  final bool isLoading;
  final Color? buttonColor;
  final Widget? loaderWidget;
  final Color? loaderColor;

  const ButtonWidget({
    super.key,
    this.onPressed,
    this.child,
    this.buttonTitle = '',
    this.fixedSize,
    this.shape,
    this.isLoading = false,
    this.buttonColor,
    this.buttonTitleColor,
    this.loaderWidget,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Utils.unfocus();
        if (!isLoading) {
          onPressed?.call();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        surfaceTintColor: AppColors.PRIMARY_COLOR,
        fixedSize: fixedSize ?? Size(double.maxFinite, 5.h),
      ),
      child: isLoading
          ? loaderWidget ??
              SizedBox(
                height: Device.screenType == ScreenType.mobile
                    ? 5.w
                    : Device.aspectRatio > 5
                        ? 3.w
                        : 5.w,
                width: Device.screenType == ScreenType.mobile
                    ? 5.w
                    : Device.aspectRatio > 5
                        ? 3.w
                        : 5.w,
                child: CircularProgressIndicator(
                  color: loaderColor ?? AppColors.SECONDARY_COLOR,
                  strokeWidth: Device.screenType == ScreenType.mobile ? 1.6 : 3.5,
                ),
              )
          : child ??
              Text(
                buttonTitle,
                style: TextStyle(
                  color: buttonTitleColor ?? AppColors.SECONDARY_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
    );
  }
}
