import 'package:collection/collection.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/in_job_screen/bloc/in_job_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InJobView extends StatefulWidget {
  const InJobView({super.key});

  @override
  State<InJobView> createState() => _InJobViewState();
}

class _InJobViewState extends State<InJobView> {
  final TextEditingController _searchPartyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InJobBloc()
        ..add(InJobStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<InJobBloc, InJobState>(
              builder: (context, state) {
                final inJobBloc = context.read<InJobBloc>();
                return Column(
                  children: [

                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.inJob,
                        titleIcon: AppAssets.inJobIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    ///Search Party
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: TextFieldWidget(
                        controller: _searchPartyController,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.SECONDARY_COLOR,
                          size: 5.w,
                        ),
                        prefixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 8.w, minWidth: 8.w),
                        suffixIcon: InkWell(
                          onTap: () async {
                            Utils.unfocus();
                            _searchPartyController.clear();
                            await inJobBloc.searchPartyName(_searchPartyController.text);
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: AppColors.SECONDARY_COLOR,
                            size: 5.w,
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 12.w, minWidth: 12.w),
                        hintText: S.current.searchParty,
                        onChanged: (value) async {
                          await inJobBloc.searchPartyName(_searchPartyController.text);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 1.h),

                    ///Jobs List
                    if (state is InJobGetJobsLoadingState && state.isLoading == true)
                      const Expanded(
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      )
                    else
                      if (inJobBloc.searchedOrdersList.isEmpty)
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
                      else
                        Expanded(
                          child: AnimationLimiter(
                            child: ListView.separated(
                              itemCount: inJobBloc.searchedOrdersList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                              itemBuilder: (context, index) {
                                final party = inJobBloc.searchedOrdersList[index];
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
                                                    party.partyName ?? '',
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
                                          tilePadding: EdgeInsets.only(left: 3.w, right: 2.w),
                                          dense: true,
                                          collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                          backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                          iconColor: AppColors.SECONDARY_COLOR,
                                          collapsedShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          children: [
                                            Divider(
                                              color: AppColors.HINT_GREY_COLOR,
                                              thickness: 1,
                                              height: 2,
                                            ),
                                            SizedBox(height: 2.h),

                                            ///Products
                                            AnimationLimiter(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: AnimationConfiguration.toStaggeredList(
                                                  duration: const Duration(milliseconds: 400),
                                                  childAnimationBuilder: (child) =>
                                                      SlideAnimation(
                                                        verticalOffset: 50.0,
                                                        child: FadeInAnimation(child: child),
                                                      ),
                                                  children: [
                                                    for (int i = 0; i < (party.productData?.length ?? 0); i++) ...[
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 2.w),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [

                                                            ///Product Name
                                                            SizedBox(
                                                              width: 70.w,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "✤",
                                                                    style: TextStyle(
                                                                      color: AppColors.BLACK_COLOR,
                                                                      fontSize: 16.sp,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 2.w),
                                                                  Flexible(
                                                                    child: Text(
                                                                      party.productData?[i].productName ?? "",
                                                                      style: TextStyle(
                                                                        color: AppColors.BLACK_COLOR,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(width: 2.w),

                                                            ///Product Type
                                                            FaIcon(
                                                              party.productData?[i].orderType == "Box"
                                                                  ? FontAwesomeIcons.box
                                                                  : party.productData?[i].orderType == "Sheet"
                                                                  ? FontAwesomeIcons.sheetPlastic
                                                                  : FontAwesomeIcons.toiletPaper,
                                                              size: 5.w,
                                                              color: AppColors.DARK_RED_COLOR,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h),

                                                      ///Orders
                                                      AnimationLimiter(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: AnimationConfiguration.toStaggeredList(
                                                            duration: const Duration(milliseconds: 400),
                                                            childAnimationBuilder: (child) =>
                                                                SlideAnimation(
                                                                  verticalOffset: 50.0,
                                                                  child: FadeInAnimation(child: child),
                                                                ),
                                                            children: [
                                                              for (int j = 0; j < (party.productData?[i].orderData?.length ?? 0); j++) ...[
                                                                ExpansionTile(
                                                                  title: SizedBox(
                                                                    height: Device.screenType == ScreenType.tablet
                                                                        ? Device.aspectRatio > 0.5
                                                                        ? 5.5.h
                                                                        : 4.5.h
                                                                        : null,
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [

                                                                        ///Date
                                                                        Text(
                                                                          "❖",
                                                                          style: TextStyle(
                                                                            fontSize: 16.sp,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: AppColors.SECONDARY_COLOR,
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 2.w),
                                                                        Flexible(
                                                                          child: Text(
                                                                            "${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd, hh:mm:ss").parse("${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}").toLocal())}, ${daysGone(date: "${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}")} ${(daysGone(
                                                                                date: "${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}") ?? 0) < 2 ? "Day" : "Days"}",
                                                                            style: TextStyle(
                                                                              color: AppColors.BLACK_COLOR,
                                                                              fontSize: 16.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  dense: true,
                                                                  collapsedShape: InputBorder.none,
                                                                  shape: InputBorder.none,
                                                                  collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                                                  backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                                                  iconColor: AppColors.SECONDARY_COLOR,
                                                                  tilePadding: EdgeInsets.only(left: 4.w, right: 2.w),
                                                                  children: [
                                                                    Divider(
                                                                      color: AppColors.HINT_GREY_COLOR,
                                                                      thickness: 1,
                                                                      height: 2,
                                                                    ),
                                                                    SizedBox(height: 0.5.h),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                                      child: AnimationLimiter(
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: AnimationConfiguration.toStaggeredList(
                                                                            duration: const Duration(milliseconds: 175),
                                                                            childAnimationBuilder: (child) =>
                                                                                ScaleAnimation(
                                                                                  child: FadeInAnimation(child: child),
                                                                                ),
                                                                            children: [
                                                                              EasyStepper(
                                                                                activeStep: inJobBloc.activeStepList
                                                                                    .firstWhereOrNull((element) => element.keys.firstOrNull == party.productData?[i].orderData?[j].orderId)
                                                                                    ?.values
                                                                                    .first ?? 0,
                                                                                borderThickness: 3,
                                                                                defaultStepBorderType: BorderType.normal,
                                                                                activeStepBorderColor: AppColors.DARK_RED_COLOR,
                                                                                finishedStepBorderColor: AppColors.DARK_GREEN_COLOR,
                                                                                finishedStepBackgroundColor: AppColors.DARK_GREEN_COLOR,
                                                                                enableStepTapping: true,
                                                                                onStepReached: (index) async {
                                                                                  final currentActiveStep = inJobBloc.activeStepList
                                                                                      .firstWhereOrNull((element) => element.keys.firstOrNull == party.productData?[i].orderData?[j].orderId)
                                                                                      ?.values
                                                                                      .first ?? 0;
                                                                                  if(index == currentActiveStep){
                                                                                    await showConfirmDialog(
                                                                                      context: context,
                                                                                      title: S.current.nextStartJobConfirmText.replaceAll("Job Name", party.productData?[i].orderData?[j].jobData?[index].jobName ?? ""),
                                                                                      onPressed: () async {
                                                                                        if (party.productData?[i].orderData?[j].jobData?[index].jobId?.isNotEmpty == true) {
                                                                                          inJobBloc.add(
                                                                                            InJobCompleteJobClickEvent(
                                                                                              jobId: party.productData?[i].orderData?[j].jobData?[index].jobId ?? "",
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                    );
                                                                                  }
                                                                                },
                                                                                lineStyle: LineStyle(
                                                                                  finishedLineColor: AppColors.DARK_GREEN_COLOR,
                                                                                  lineType: LineType.normal,
                                                                                  lineThickness: 1.w,
                                                                                  lineWidth: 10.w,
                                                                                  defaultLineColor: AppColors.SECONDARY_COLOR,
                                                                                ),
                                                                                titlesAreLargerThanSteps: true,
                                                                                unreachedStepBorderColor: AppColors.SECONDARY_COLOR.withOpacity(0.25),
                                                                                steps: [
                                                                                  for (int jobIndex = 0; jobIndex < (party.productData?[i].orderData?[j].jobData?.length ?? 0); jobIndex++) ...[
                                                                                    EasyStep(
                                                                                      customStep: Opacity(
                                                                                        opacity: (inJobBloc.activeStepList
                                                                                            .firstWhereOrNull((element) => element.keys.firstOrNull == party.productData?[i].orderData?[j].orderId)
                                                                                            ?.values
                                                                                            .first ?? 0) >= 0 ? 1 : 0.3,
                                                                                        child: Image.asset(
                                                                                          party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Paper Cutting"
                                                                                              ? AppAssets.paperCuttingIcon
                                                                                              : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Pesting"
                                                                                              ? AppAssets.pestingIcon
                                                                                              : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Corrugation"
                                                                                              ? AppAssets.corrugationIcon
                                                                                              : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Slitting - Scoring"
                                                                                              ? AppAssets.slittingScoringIcon
                                                                                              : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Slitting In Line"
                                                                                              ? AppAssets.slittingInLineIcon
                                                                                              : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Flexo Printing"
                                                                                              ? AppAssets.flexoPrintingIcon : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Glue Joint" || party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Pin Joint"
                                                                                              ? AppAssets.jointIcon : AppAssets.punchingIcon,
                                                                                          width: party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Corrugation" || party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Punching" ? 9.w : party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Glue Joint" || party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Pin Joint" ||
                                                                                              party.productData?[i].orderData?[j].jobData?[jobIndex].jobName == "Slitting - Scoring" ? 8.w : 7.w,
                                                                                        ),
                                                                                      ),
                                                                                      customTitle: Text(
                                                                                        party.productData?[i].orderData?[j].jobData?[jobIndex].jobName ?? "",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          color: jobIndex == inJobBloc.activeStepList
                                                                                              .firstWhereOrNull((element) => element.keys.firstOrNull == party.productData?[i].orderData?[j].orderId)
                                                                                              ?.values
                                                                                              .first
                                                                                              ? AppColors.DARK_RED_COLOR
                                                                                              : jobIndex < (inJobBloc.activeStepList
                                                                                              .firstWhereOrNull((element) => element.keys.firstOrNull == party.productData?[i].orderData?[j].orderId)
                                                                                              ?.values
                                                                                              .first ?? 0)
                                                                                              ? AppColors.DARK_GREEN_COLOR
                                                                                              : AppColors.SECONDARY_COLOR,
                                                                                          fontSize: 14.sp,
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 1.h),
                                                              ]
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 1.h),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 2.h,
                                );
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

  Future<void> showConfirmDialog({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
  }) async {
    final inJobBloc = context.read<InJobBloc>();

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'string',
      transitionDuration: const Duration(milliseconds: 400),
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
                        value: inJobBloc,
                        child: BlocConsumer<InJobBloc, InJobState>(
                          listener: (context, state) {
                            if (state is InJobCompleteJobSuccessState) {
                              context.pop();
                              Utils.handleMessage(message: state.successMessage);
                              context.read<InJobBloc>().add(const InJobGetJobsEvent(isLoading: false));
                            }
                            if (state is InJobCompleteJobFailedState) {
                              context.pop();
                              Utils.handleMessage(message: state.failedMessage, isError: true);
                            }
                          },
                          builder: (context, state) {
                            return ButtonWidget(
                              onPressed: onPressed,
                              isLoading: state is InJobCompleteJobLoadingState && state.isLoading,
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

  int? daysGone({required String date}) {
    return DateTime
        .now()
        .difference(DateFormat("yyyy-MM-dd, hh:mm:ss").parse(date).toLocal())
        .inDays;
  }
}