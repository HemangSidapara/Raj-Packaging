import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_styles.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/models/production_report_models/get_production_report_model.dart' as get_report;
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/production_report_screen/bloc/production_report_bloc.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductionReportView extends StatefulWidget {
  const ProductionReportView({super.key});

  @override
  State<ProductionReportView> createState() => _ProductionReportViewState();
}

class _ProductionReportViewState extends State<ProductionReportView> with TickerProviderStateMixin {
  late TabController tabController;

  List<String> tabList = [
    S.current.production,
    S.current.reports,
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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
                    SizedBox(height: 2.h),

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
                    SizedBox(height: 2.h),

                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ///Production
                          RefreshIndicator(
                            onRefresh: () async {
                              productionReportBloc.add(ProductionReportGetProductionEvent(isLoading: false));
                            },
                            backgroundColor: AppColors.PRIMARY_COLOR,
                            color: AppColors.SECONDARY_COLOR,
                            strokeWidth: 1.5,
                            child: Column(
                              children: [
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
                                    child: Column(
                                      children: [
                                        ///Headings
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                spacing: 2.w,
                                                children: [
                                                  ///Date
                                                  SizedBox(
                                                    width: 30.w,
                                                    child: Text(
                                                      S.current.date,
                                                      style: AppStyles.size16W600TextStyle.copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                  ),

                                                  ///Meters
                                                  SizedBox(
                                                    width: 23.w,
                                                    child: Text(
                                                      S.current.meters,
                                                      style: AppStyles.size16W600TextStyle.copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                  ),

                                                  ///KGs
                                                  SizedBox(
                                                    width: 23.w,
                                                    child: Text(
                                                      S.current.kgs,
                                                      style: AppStyles.size16W600TextStyle.copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///Data
                                        Expanded(
                                          child: AnimationLimiter(
                                            child: ListView.separated(
                                              itemCount: productionList.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                              itemBuilder: (context, index) {
                                                final production = productionList[index];
                                                return AnimationConfiguration.staggeredList(
                                                  position: index,
                                                  duration: const Duration(milliseconds: 400),
                                                  child: SlideAnimation(
                                                    verticalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                      child: Card(
                                                        color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                        clipBehavior: Clip.antiAlias,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            spacing: 2.w,
                                                            children: [
                                                              ///Date
                                                              SizedBox(
                                                                width: 30.w,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '❖',
                                                                      style: TextStyle(
                                                                        fontSize: 16.sp,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: AppColors.SECONDARY_COLOR,
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 2.w),
                                                                    Flexible(
                                                                      child: Text(
                                                                        production.date ?? "",
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

                                                              ///Meters
                                                              SizedBox(
                                                                width: 23.w,
                                                                child: Text(
                                                                  production.meters != null ? NumberFormat.decimalPattern().format(production.meters) : "",
                                                                  style: TextStyle(
                                                                    fontSize: 16.sp,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColors.SECONDARY_COLOR,
                                                                  ),
                                                                ),
                                                              ),

                                                              ///KGs
                                                              SizedBox(
                                                                width: 23.w,
                                                                child: Text(
                                                                  production.kgs != null ? NumberFormat.decimalPattern().format(production.kgs) : "",
                                                                  style: TextStyle(
                                                                    fontSize: 16.sp,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColors.SECONDARY_COLOR,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                  ),
                              ],
                            ),
                          ),

                          ///Reports
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: SfCartesianChart(
                                  enableAxisAnimation: true,
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    elevation: 5,
                                    color: AppColors.WHITE_COLOR,
                                    shadowColor: AppColors.HINT_GREY_COLOR,
                                    builder: (data, point, series, pointIndex, seriesIndex) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///Date
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.PRIMARY_COLOR,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  height: 1.5.w,
                                                  width: 1.5.w,
                                                ),
                                                SizedBox(width: 1.w),
                                                Text(
                                                  '${S.current.date}: ',
                                                  style: TextStyle(
                                                    color: AppColors.HINT_GREY_COLOR,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                Text(
                                                  '${data.date ?? 0}',
                                                  style: TextStyle(
                                                    color: AppColors.SECONDARY_COLOR,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            ///Meters
                                            if (series.name == S.current.meters) ...[
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.PRIMARY_COLOR,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    height: 1.5.w,
                                                    width: 1.5.w,
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  Text(
                                                    '${S.current.meters}: ',
                                                    style: TextStyle(
                                                      color: AppColors.HINT_GREY_COLOR,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.meters != null ? NumberFormat.decimalPattern().format(data.meters) : '-',
                                                    style: TextStyle(
                                                      color: AppColors.SECONDARY_COLOR,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],

                                            ///Kgs
                                            if (series.name == S.current.kgs) ...[
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.PRIMARY_COLOR,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    height: 1.5.w,
                                                    width: 1.5.w,
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  Text(
                                                    '${S.current.kgs}: ',
                                                    style: TextStyle(
                                                      color: AppColors.HINT_GREY_COLOR,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.kgs != null ? NumberFormat.decimalPattern().format(data.kgs) : '-',
                                                    style: TextStyle(
                                                      color: AppColors.SECONDARY_COLOR,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true,
                                    enablePanning: true,
                                  ),
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    iconWidth: 5.w,
                                    textStyle: AppStyles.size16W600TextStyle.copyWith(fontWeight: FontWeight.w400),
                                    itemPadding: 10.w,
                                  ),
                                  primaryXAxis: DateTimeAxis(
                                    majorGridLines: MajorGridLines(
                                      width: 0.5,
                                      color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                    ),
                                    labelStyle: AppStyles.size14W600TextStyle,
                                    title: AxisTitle(
                                      text: S.current.date,
                                      textStyle: AppStyles.size16W600TextStyle,
                                    ),
                                    autoScrollingDelta: 4,
                                    autoScrollingMode: AutoScrollingMode.start,
                                    autoScrollingDeltaType: DateTimeIntervalType.days,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    majorGridLines: MajorGridLines(
                                      width: 0.5,
                                      color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                    ),
                                    labelStyle: AppStyles.size14W600TextStyle,
                                    title: AxisTitle(
                                      text: "${S.current.meters} / ${S.current.kgs}",
                                      textStyle: AppStyles.size16W600TextStyle,
                                    ),
                                  ),
                                  series: <CartesianSeries<get_report.Data, DateTime>>[
                                    LineSeries<get_report.Data, DateTime>(
                                      dataSource: productionReportBloc.productionList,
                                      xValueMapper: (get_report.Data data, _) => DateFormat("dd-MM-yyyy").tryParse(data.date ?? ""),
                                      yValueMapper: (get_report.Data data, _) => data.meters,
                                      name: S.current.meters,
                                      markerSettings: MarkerSettings(
                                        color: AppColors.WARNING_COLOR,
                                        isVisible: true,
                                        width: 3.w,
                                        height: 3.w,
                                        borderWidth: 0,
                                      ),
                                    ),
                                    LineSeries<get_report.Data, DateTime>(
                                      dataSource: productionReportBloc.productionList,
                                      xValueMapper: (get_report.Data data, _) => DateFormat("dd-MM-yyyy").tryParse(data.date ?? ""),
                                      yValueMapper: (get_report.Data data, _) => data.kgs,
                                      name: S.current.kgs,
                                      markerSettings: MarkerSettings(
                                        color: AppColors.WARNING_COLOR,
                                        isVisible: true,
                                        height: 3.w,
                                        width: 3.w,
                                        borderWidth: 0,
                                      ),
                                    ),
                                  ],
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
