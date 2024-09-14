import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/job_data_screen/bloc/job_data_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JobDataView extends StatefulWidget {
  const JobDataView({super.key});

  @override
  State<JobDataView> createState() => _JobDataViewState();
}

class _JobDataViewState extends State<JobDataView> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobDataBloc()..add(JobDataStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<JobDataBloc, JobDataState>(
              builder: (context, state) {
                final jobDataBloc = context.read<JobDataBloc>();
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.jobData,
                        titleIcon: AppAssets.jobDataIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    ///Tabs
                    if (state is JobDataGetJobsLoadingState && state.isLoading == true)
                      const Expanded(
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      )
                    else if (jobDataBloc.jobsList.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            S.current.noDataFound,
                            style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else ...[
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        dividerColor: AppColors.TRANSPARENT,
                        labelPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: AppColors.PRIMARY_COLOR.withOpacity(0.5),
                        tabs: [
                          for (int i = 0; i < 5; i++)
                            Text(
                              jobDataBloc.jobsList.first.toJson().keys.toList()[i],
                              style: TextStyle(
                                color: AppColors.DARK_GREEN_COLOR.withOpacity(0.8),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            for (int i = 0; i < 5; i++)
                              if (jobDataBloc.jobsList.first.toJson()[jobDataBloc.jobsList.first.toJson().keys.toList()[i]].isEmpty)
                                Center(
                                  child: Text(
                                    S.current.noDataFound,
                                    style: TextStyle(
                                      color: AppColors.PRIMARY_COLOR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                )
                              else
                                ListView.separated(
                                  itemCount: jobDataBloc.jobsList.first.toJson()[jobDataBloc.jobsList.first.toJson().keys.toList()[i]].length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            jobDataBloc.jobsList.first.toJson()[jobDataBloc.jobsList.first.toJson().keys.toList()[i]][index]["description"],
                                            style: TextStyle(
                                              color: AppColors.PRIMARY_COLOR,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        IconButton(
                                          onPressed: () async {
                                            await showConfirmDialog(
                                              context: context,
                                              title: S.current.nextStartJobConfirmText.replaceAll("Job Name", jobDataBloc.jobsList.first.toJson().keys.toList()[i]),
                                              onPressed: () async {
                                                jobDataBloc.add(
                                                  JobDataCompleteJobClickEvent(
                                                    jobId: jobDataBloc.jobsList.first.toJson()[jobDataBloc.jobsList.first.toJson().keys.toList()[i]][index]["jobId"] ?? "",
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          style: IconButton.styleFrom(
                                            backgroundColor: AppColors.DARK_GREEN_COLOR,
                                            maximumSize: Size(8.w, 8.w),
                                            minimumSize: Size(8.w, 8.w),
                                            padding: EdgeInsets.zero,
                                          ),
                                          icon: Icon(
                                            Icons.done_rounded,
                                            color: AppColors.WHITE_COLOR,
                                            size: 5.w,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: AppColors.HINT_GREY_COLOR,
                                      thickness: 1.2,
                                    );
                                  },
                                )
                          ],
                        ),
                      )
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmDialog({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
  }) async {
    final jobDataBloc = context.read<JobDataBloc>();

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'string',
      transitionDuration: const Duration(milliseconds: 375),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          ),
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
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),
                Icon(
                  Icons.done_all,
                  color: AppColors.DARK_GREEN_COLOR,
                  size: 8.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Cancel
                      ButtonWidget(
                        onPressed: () {
                          context.pop();
                        },
                        fixedSize: Size(30.w, 5.h),
                        buttonTitle: S.current.cancel,
                        buttonColor: AppColors.SECONDARY_COLOR,
                        buttonTitleColor: AppColors.PRIMARY_COLOR,
                      ),

                      ///Confirm
                      BlocProvider.value(
                        value: jobDataBloc,
                        child: BlocConsumer<JobDataBloc, JobDataState>(
                          listener: (context, state) {
                            if (state is JobDataCompleteJobSuccessState) {
                              context.pop();
                              Utils.handleMessage(message: state.successMessage);
                              context.read<JobDataBloc>().add(const JobDataGetJobsEvent(isLoading: false));
                            }
                            if (state is JobDataCompleteJobFailedState) {
                              context.pop();
                              Utils.handleMessage(message: state.failedMessage, isError: true);
                            }
                          },
                          builder: (context, state) {
                            return ButtonWidget(
                              onPressed: onPressed,
                              isLoading: state is JobDataCompleteJobLoadingState && state.isLoading,
                              fixedSize: Size(30.w, 5.h),
                              buttonTitle: S.current.confirm,
                              buttonColor: AppColors.DARK_GREEN_COLOR,
                              loaderColor: AppColors.PRIMARY_COLOR,
                              buttonTitleColor: AppColors.PRIMARY_COLOR,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
