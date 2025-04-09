import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/production_report_screen/bloc/production_report_bloc.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductionReportView extends StatefulWidget {
  const ProductionReportView({super.key});

  @override
  State<ProductionReportView> createState() => _ProductionReportViewState();
}

class _ProductionReportViewState extends State<ProductionReportView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductionReportBloc()..add(ProductionReportStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<ProductionReportBloc, ProductionReportState>(
              builder: (context, state) {
                final productionReportBloc = context.read<ProductionReportBloc>();
                final productionList = productionReportBloc.productionList;
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.productionReport,
                        titleIcon: AppAssets.productionReportIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    if (state is ProductionReportGetProductionLoadingState && state.isLoading == true)
                      const Expanded(
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      )
                    else if (productionList.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            S.current.noDataFound,
                            style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: AnimationLimiter(
                          child: ListView.separated(
                            itemCount: productionList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 400),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Card(
                                      color: AppColors.TRANSPARENT,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ExpansionTile(
                                        title: SizedBox(
                                          height: Device.screenType == ScreenType.tablet
                                              ? Device.aspectRatio < 0.5
                                                  ? 4.h
                                                  : 6.h
                                              : null,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${index + 1}. ',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.SECONDARY_COLOR,
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Flexible(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                    color: AppColors.SECONDARY_COLOR,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        tilePadding: EdgeInsets.only(
                                          left: 3.w,
                                          right: Device.screenType == ScreenType.tablet ? 0.5.w : 2.w,
                                        ),
                                        trailing: const SizedBox(),
                                        dense: true,
                                        collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                        backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                        iconColor: AppColors.SECONDARY_COLOR,
                                        collapsedShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 2.h);
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
