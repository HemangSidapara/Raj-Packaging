import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<String> _contentRouteList = [
    if (getData(AppConstance.role) == AppConstance.admin) Routes.pendingOrdersScreen,
    if (getData(AppConstance.role) == AppConstance.admin) Routes.inJobScreen,
    Routes.completedScreen,
    Routes.jobDataScreen,
    if (getData(AppConstance.role) == AppConstance.admin) Routes.productionReportScreen,
    if (getData(AppConstance.role) == AppConstance.admin) Routes.inventoryScreen else Routes.consumeHomeScreen,
  ];

  final List<String> _contentList = [
    if (getData(AppConstance.role) == AppConstance.admin) S.current.pendingOrders,
    if (getData(AppConstance.role) == AppConstance.admin) S.current.inJob,
    S.current.completed,
    S.current.jobData,
    if (getData(AppConstance.role) == AppConstance.admin) S.current.productionReport,
    S.current.inventory,
  ];

  final List<String> _contentIconList = [
    if (getData(AppConstance.role) == AppConstance.admin) AppAssets.pendingIcon,
    if (getData(AppConstance.role) == AppConstance.admin) AppAssets.inJobIcon,
    AppAssets.completedIcon,
    AppAssets.jobDataIcon,
    if (getData(AppConstance.role) == AppConstance.admin) AppAssets.productionReportIcon,
    AppAssets.inventoryIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w).copyWith(bottom: 5.h),
      child: Column(
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "${S.current.hello}${getData(AppConstance.userName) != null ? "${getData(AppConstance.userName)} " : ""}",
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.8),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const HandShakenAnimation(),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
            ],
          ),
          SizedBox(height: 2.h),

          ///Features
          Expanded(
            child: CustomScrollView(
              slivers: [
                ///Create Order
                if (getData(AppConstance.role) == AppConstance.admin) ...[
                  SliverToBoxAdapter(
                    child: ElevatedButton(
                      onPressed: () async {
                        context.goNamed(Routes.createOrderScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.LIGHT_SECONDARY_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 65.w,
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.createOrderImage,
                                    width: 18.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    S.current.createOrder,
                                    style: TextStyle(
                                      color: AppColors.SECONDARY_COLOR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              AppAssets.frontIcon,
                              width: 9.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 2.h),
                  ),
                ],

                ///Order Details
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.h,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 2.h,
                    ),
                    itemCount: _contentList.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          context.goNamed(_contentRouteList[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.LIGHT_SECONDARY_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h).copyWith(bottom: 0.5.h, right: 2.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _contentList[index],
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: AppColors.SECONDARY_COLOR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  _contentIconList[index],
                                  width: index == 2 ? 13.w : 14.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
