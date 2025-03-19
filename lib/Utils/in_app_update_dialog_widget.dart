import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Screens/splash_screen/bloc/splash_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showUpdateDialog<B extends StateStreamable<State>, State>({
  required BuildContext context,
  required void Function() onUpdate,
  required B bloc,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    barrierLabel: 'string',
    barrierColor: AppColors.TRANSPARENT,
    transitionDuration: const Duration(milliseconds: 600),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.WHITE_COLOR,
            ),
            height: 35.h,
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.updateAnim,
                  height: 10.h,
                ),
                SizedBox(height: 2.h),
                Text(
                  S.current.newVersionAvailable,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                BlocBuilder<B, State>(
                  bloc: bloc,
                  builder: (context, state) {
                    final isUpdateLoading = (state is SplashUpdateProgressState) && state.isUpdateLoading;
                    final downloadedProgress = (state is SplashUpdateProgressState) ? state.downloadedProgress : 0;
                    return ButtonWidget(
                      onPressed: isUpdateLoading ? null : onUpdate,
                      isLoading: isUpdateLoading,
                      loaderWidget: Row(
                        children: [
                          Text(
                            "$downloadedProgress%",
                            style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5.w,
                                  width: 5.w,
                                  child: CircularProgressIndicator(
                                    color: AppColors.PRIMARY_COLOR,
                                    strokeWidth: 1.6,
                                    value: downloadedProgress / 100,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                              ],
                            ),
                          )
                        ],
                      ),
                      buttonTitle: Platform.isIOS ? "Update from Testflight" : S.current.update,
                      buttonTitleColor: AppColors.PRIMARY_COLOR,
                      buttonColor: AppColors.SECONDARY_COLOR,
                    );
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
