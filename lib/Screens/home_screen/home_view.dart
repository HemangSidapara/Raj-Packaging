import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Screens/home_screen/bloc/home_bloc.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        await showExitDialog(context);
      },
      child: BlocProvider(
        create: (context) => HomeBloc()..add(HomeStartedEvent()),
        child: Scaffold(
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.SECONDARY_COLOR,
              boxShadow: [
                BoxShadow(
                  color: AppColors.MAIN_BORDER_COLOR.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 80,
                )
              ],
            ),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final items = context.read<HomeBloc>().bottomItemWidgetList;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < items.length; i++)
                      SizedBox(
                        width: 100.w / items.length,
                        child: BottomNavigationBarItem(
                          index: i,
                          iconName: context.read<HomeBloc>().listOfImages[i],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final homeBloc = context.read<HomeBloc>();
              return PageView(
                controller: homeBloc.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: homeBloc.bottomItemWidgetList,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget BottomNavigationBarItem({
    required int index,
    required String iconName,
  }) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            context.read<HomeBloc>().add(HomeChangeBottomIndexEvent(bottomIndex: index));
          },
          child: SizedBox(
            height: 12.w,
            width: 12.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconName,
                  width: 8.w,
                  color: state is HomeChangeBottomIndexState && state.bottomIndex == index ? AppColors.TERTIARY_COLOR : AppColors.WHITE_COLOR,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showExitDialog(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'string',
      transitionDuration: const Duration(milliseconds: 350),
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
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.WHITE_COLOR,
            ),
            height: 30.h,
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.WARNING_COLOR,
                  size: 8.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  S.current.areYouSureYouWantToExitTheApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ERROR_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///No
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.SECONDARY_COLOR,
                        fixedSize: Size(27.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        S.current.no,
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    ///Yes, exit
                    ElevatedButton(
                      onPressed: () async {
                        await SystemNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.DARK_RED_COLOR,
                        fixedSize: Size(33.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        S.current.yesExit,
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
