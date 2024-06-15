import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_strings.dart';
import 'package:raj_packaging/Screens/splash_screen/splash_bloc.dart';
import 'package:raj_packaging/Utils/in_app_update_dialog_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) async {
          if (state is SplashOnUpdateAvailable) {
            await showUpdateDialog(
              context: context,
              onUpdate: () async {
                context.read<SplashBloc>().add(SplashDownloadAndInstall());
              },
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.SECONDARY_COLOR,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///Image
                      Lottie.asset(
                        AppAssets.splashAnim,
                        height: 50.h,
                      ),
                      SizedBox(height: 2.h),

                      ///Name
                      Text(
                        AppStrings.appName,
                        style: TextStyle(
                          color: AppColors.WHITE_COLOR,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: context.read<SplashBloc>().currentVersion.isNotEmpty ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        AppConstance.appVersion.replaceAll('1.0.0', context.read<SplashBloc>().currentVersion),
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR.withOpacity(0.55),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  AppStrings.poweredByMindwaveInfoway,
                  style: TextStyle(
                    color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.55),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
