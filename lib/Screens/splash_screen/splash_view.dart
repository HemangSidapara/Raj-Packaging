import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_strings.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/Screens/splash_screen/bloc/splash_bloc.dart';
import 'package:raj_packaging/Utils/in_app_update_dialog_widget.dart';
import 'package:raj_packaging/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return BlocProvider(
      create: (context) =>
      SplashBloc()
        ..add(SplashStartedEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) async {
          if (state is SplashOnUpdateAvailableState) {
            await showUpdateDialog<SplashBloc, SplashState>(
              context: context,
              onUpdate: () async {
                context.read<SplashBloc>().add(SplashDownloadAndInstallStartEvent());
              },
              bloc: context.read<SplashBloc>(),
            );
          }
          if (context.mounted && state is SplashAuthorizedState) {
            context.goNamed(Routes.homeScreen);
          }
          if (context.mounted && state is SplashUnauthorizedState) {
            context.goNamed(Routes.signInScreen);
          }
        },
        child: Scaffold(
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
                  buildWhen: (previous, current) => current is SplashCurrentVersionState,
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: (state is SplashCurrentVersionState) && state.currentVersion.isNotEmpty ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        AppConstance.appVersion.replaceAll('1.0.0', (state is SplashCurrentVersionState) ? state.currentVersion : ""),
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.55),
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
                    color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.55),
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
