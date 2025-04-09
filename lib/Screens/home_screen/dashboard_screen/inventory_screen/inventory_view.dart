import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/bloc/inventory_bloc.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> with TickerProviderStateMixin {
  late TabController tabController;

  List<String> tabList = [
    S.current.entry,
    S.current.stock,
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc()..add(InventoryStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                final inventoryBloc = context.read<InventoryBloc>();
                final inventoryList = inventoryBloc.inventoryList;
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.inventory,
                        titleIcon: AppAssets.inventoryIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    ///Tabs
                    TabBar(
                      controller: tabController,
                      dividerColor: AppColors.TRANSPARENT,
                      labelPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.PRIMARY_COLOR.withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      tabs: [
                        for (int i = 0; i < tabList.length; i++)
                          Text(
                            tabList[i],
                            style: TextStyle(
                              color: AppColors.DARK_GREEN_COLOR.withValues(alpha: 0.8),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),

                    ///View
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Column(
                            children: [],
                          ),
                          Column(
                            children: [
                              if (state is InventoryGetInventoryLoadingState && state.isLoading == true)
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
                          ),
                        ],
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
