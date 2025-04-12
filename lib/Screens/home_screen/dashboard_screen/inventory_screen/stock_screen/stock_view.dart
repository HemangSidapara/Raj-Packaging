import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_styles.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bloc/stock_bloc.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc()..add(StockStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                final stockBloc = context.read<StockBloc>();
                final inventoryList = stockBloc.inventoryList;
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.stock,
                        titleIcon: AppAssets.inventoryIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    ///Stock
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          stockBloc.add(StockGetInventoryEvent(isLoading: false));
                        },
                        backgroundColor: AppColors.PRIMARY_COLOR,
                        color: AppColors.SECONDARY_COLOR,
                        strokeWidth: 1.5,
                        child: Column(
                          children: [
                            if (state is StockGetInventoryLoadingState && state.isLoading == true)
                              const Expanded(
                                child: Center(
                                  child: LoadingWidget(),
                                ),
                              )
                            else if (inventoryList.isEmpty)
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
                                    itemCount: inventoryList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                    itemBuilder: (context, index) {
                                      final inventory = inventoryList[index];
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
                                                      DecoratedBox(
                                                        decoration: BoxDecoration(
                                                          color: inventory.entryType == "Add" ? AppColors.DARK_GREEN_COLOR : AppColors.DARK_RED_COLOR,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: SizedBox(
                                                          width: 3.w,
                                                          height: 3.w,
                                                        ),
                                                      ),
                                                      SizedBox(width: 2.w),

                                                      ///Item Type
                                                      Expanded(
                                                        child: Text(
                                                          inventory.itemType ?? "",
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
                                                children: [
                                                  SizedBox(height: 1.h),

                                                  ///Date & Entry Type
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                    child: Row(
                                                      children: [
                                                        ///Date
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.date}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.createdDate ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),

                                                        ///Entry Type
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.entry}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.entryType == "Add" ? S.current.add : S.current.consume,
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),

                                                  ///Size & GSM
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ///Size
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.size}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.size ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),

                                                        ///GSM
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.gsm}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.gsm ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),

                                                  ///BF & Shade
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ///BF
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.bf}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.bf ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),

                                                        ///Shade
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.shade}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.shade ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),

                                                  ///BF & Shade
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ///BF
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.bf}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.bf ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),

                                                        ///Shade
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.shade}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.shade ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),

                                                  ///Weight & Quantity
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ///Weight
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.weight}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.weight ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),

                                                        ///Quantity
                                                        SizedBox(
                                                          width: 38.w,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${S.current.quantity}: ",
                                                                style: AppStyles.size15W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                              Text(
                                                                inventory.quantity ?? "",
                                                                style: AppStyles.size16W600TextStyle.copyWith(color: AppColors.SECONDARY_COLOR),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                ],
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
