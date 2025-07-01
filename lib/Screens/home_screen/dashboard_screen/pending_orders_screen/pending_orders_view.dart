import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/pending_orders_screen/bloc/pending_orders_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingOrdersView extends StatefulWidget {
  const PendingOrdersView({super.key});

  @override
  State<PendingOrdersView> createState() => _PendingOrdersViewState();
}

class _PendingOrdersViewState extends State<PendingOrdersView> {
  final TextEditingController _searchPartyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PendingOrdersBloc()..add(PendingOrdersStartedEvent()),
      child: GestureDetector(
        onTap: Utils.unfocus,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: BlocBuilder<PendingOrdersBloc, PendingOrdersState>(
                builder: (context, state) {
                  final pendingOrdersBloc = context.read<PendingOrdersBloc>();
                  return Column(
                    children: [
                      ///Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: CustomHeaderWidget(
                          title: S.current.pendingOrders,
                          titleIcon: AppAssets.pendingIcon,
                          onBackPressed: () {
                            context.pop();
                          },
                          titleIconSize: 9.w,
                        ),
                      ),
                      SizedBox(height: 2.h),

                      ///Search Orders
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
                              await pendingOrdersBloc.searchPartyName(_searchPartyController.text);
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
                            await pendingOrdersBloc.searchPartyName(_searchPartyController.text);
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 1.h),

                      ///Orders List
                      if (state is PendingOrdersGetOrdersLoadingState && state.isLoading == true)
                        const Expanded(
                          child: Center(
                            child: LoadingWidget(),
                          ),
                        )
                      else if (pendingOrdersBloc.searchedOrdersList.isEmpty)
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
                              itemCount: pendingOrdersBloc.searchedOrdersList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                              itemBuilder: (context, index) {
                                final party = pendingOrdersBloc.searchedOrdersList[index];
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
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

                                                ///Edit
                                                if (Device.screenType == ScreenType.tablet) ...[
                                                  SizedBox(width: 2.w),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await showBottomSheetPartyEdit(
                                                        context: context,
                                                        partyId: party.partyId ?? "",
                                                        partyName: party.partyName ?? "",
                                                        phoneNumber: party.partyPhone ?? "",
                                                      );
                                                    },
                                                    style: IconButton.styleFrom(
                                                      backgroundColor: AppColors.WARNING_COLOR,
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                      padding: EdgeInsets.zero,
                                                      elevation: 4,
                                                      maximumSize: Device.aspectRatio > 0.5 ? Size(4.5.h, 4.5.h) : Size(8.5.w, 8.5.w),
                                                      minimumSize: Device.aspectRatio > 0.5 ? Size(4.5.h, 4.5.h) : Size(8.5.w, 8.5.w),
                                                    ),
                                                    icon: Icon(
                                                      Icons.edit_rounded,
                                                      color: AppColors.PRIMARY_COLOR,
                                                      size: Device.aspectRatio > 0.5 ? 3.w : 5.w,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          tilePadding: EdgeInsets.only(
                                            left: 3.w,
                                            right: Device.screenType == ScreenType.tablet ? 0.5.w : 2.w,
                                          ),
                                          trailing: Device.screenType == ScreenType.tablet
                                              ? const SizedBox()
                                              : IconButton(
                                                  onPressed: () async {
                                                    await showBottomSheetPartyEdit(
                                                      context: context,
                                                      partyId: party.partyId ?? "",
                                                      partyName: party.partyName ?? "",
                                                      phoneNumber: party.partyPhone ?? "",
                                                    );
                                                  },
                                                  style: IconButton.styleFrom(
                                                    backgroundColor: AppColors.WARNING_COLOR,
                                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    padding: EdgeInsets.zero,
                                                    elevation: 4,
                                                    maximumSize: Size(7.5.w, 7.5.w),
                                                    minimumSize: Size(7.5.w, 7.5.w),
                                                  ),
                                                  icon: Icon(
                                                    Icons.edit_rounded,
                                                    color: AppColors.PRIMARY_COLOR,
                                                    size: 4.w,
                                                  ),
                                                ),
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
                                                  childAnimationBuilder: (child) => SlideAnimation(
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
                                                            childAnimationBuilder: (child) => SlideAnimation(
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
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
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
                                                                                  "${DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd, hh:mm:ss").parse("${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}").toLocal())}, ${daysGone(date: "${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}")} ${(daysGone(date: "${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}") ?? 0) < 2 ? "Day" : "Days"}",
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

                                                                        ///Create Job & Delete
                                                                        if (Device.screenType == ScreenType.tablet) ...[
                                                                          SizedBox(width: 2.w),
                                                                          IconButton(
                                                                            onPressed: () async {
                                                                              await showConfirmDialog(
                                                                                context: context,
                                                                                title: S.current.confirmItemText,
                                                                                onPressed: () async {
                                                                                  if (party.productData?[i].orderData?[j].orderId?.isNotEmpty == true) {
                                                                                    pendingOrdersBloc.add(
                                                                                      PendingOrdersCreateJobClickEvent(
                                                                                        partyId: party.partyId ?? "",
                                                                                        productId: party.productData?[i].productId ?? "",
                                                                                        orderId: party.productData?[i].orderData?[j].orderId ?? "",
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              );
                                                                            },
                                                                            style: IconButton.styleFrom(
                                                                              backgroundColor: AppColors.DARK_GREEN_COLOR,
                                                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                              padding: EdgeInsets.zero,
                                                                              elevation: 4,
                                                                              maximumSize: Size(7.5.w, 7.5.w),
                                                                              minimumSize: Size(7.5.w, 7.5.w),
                                                                            ),
                                                                            icon: FaIcon(
                                                                              FontAwesomeIcons.arrowsSpin,
                                                                              color: AppColors.PRIMARY_COLOR,
                                                                              size: 4.w,
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 2.w),
                                                                          IconButton(
                                                                            onPressed: () async {
                                                                              await showDeleteDialog(
                                                                                context: context,
                                                                                title: S.current.deleteItemText,
                                                                                onPressed: () async {
                                                                                  if (party.productData?[i].orderData?[j].orderId?.isNotEmpty == true) {
                                                                                    pendingOrdersBloc.add(PendingOrdersDeleteOrderClickEvent(orderId: party.productData?[i].orderData?[j].orderId ?? ""));
                                                                                  }
                                                                                },
                                                                              );
                                                                            },
                                                                            style: IconButton.styleFrom(
                                                                              backgroundColor: AppColors.DARK_RED_COLOR,
                                                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                              padding: EdgeInsets.zero,
                                                                              elevation: 4,
                                                                              maximumSize: Device.aspectRatio > 0.5 ? Size(4.5.h, 4.5.h) : Size(8.5.w, 8.5.w),
                                                                              minimumSize: Device.aspectRatio > 0.5 ? Size(4.5.h, 4.5.h) : Size(8.5.w, 8.5.w),
                                                                            ),
                                                                            icon: FaIcon(
                                                                              FontAwesomeIcons.solidTrashCan,
                                                                              color: AppColors.PRIMARY_COLOR,
                                                                              size: Device.aspectRatio > 0.5 ? 2.5.w : 4.w,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  trailing: Device.screenType == ScreenType.tablet
                                                                      ? const SizedBox()
                                                                      : Row(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            ///Create Job
                                                                            IconButton(
                                                                              onPressed: () async {
                                                                                await showConfirmDialog(
                                                                                  context: context,
                                                                                  title: S.current.confirmItemText,
                                                                                  onPressed: () async {
                                                                                    if (party.productData?[i].orderData?[j].orderId?.isNotEmpty == true) {
                                                                                      pendingOrdersBloc.add(
                                                                                        PendingOrdersCreateJobClickEvent(
                                                                                          partyId: party.partyId ?? "",
                                                                                          productId: party.productData?[i].productId ?? "",
                                                                                          orderId: party.productData?[i].orderData?[j].orderId ?? "",
                                                                                        ),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                );
                                                                              },
                                                                              style: IconButton.styleFrom(
                                                                                backgroundColor: AppColors.DARK_GREEN_COLOR,
                                                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                padding: EdgeInsets.zero,
                                                                                elevation: 4,
                                                                                maximumSize: Size(7.5.w, 7.5.w),
                                                                                minimumSize: Size(7.5.w, 7.5.w),
                                                                              ),
                                                                              icon: FaIcon(
                                                                                FontAwesomeIcons.arrowsSpin,
                                                                                color: AppColors.PRIMARY_COLOR,
                                                                                size: 4.w,
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 2.w),

                                                                            ///Delete
                                                                            IconButton(
                                                                              onPressed: () async {
                                                                                await showDeleteDialog(
                                                                                  context: context,
                                                                                  title: S.current.deleteItemText,
                                                                                  onPressed: () async {
                                                                                    if (party.productData?[i].orderData?[j].orderId?.isNotEmpty == true) {
                                                                                      pendingOrdersBloc.add(PendingOrdersDeleteOrderClickEvent(orderId: party.productData?[i].orderData?[j].orderId ?? ""));
                                                                                    }
                                                                                  },
                                                                                );
                                                                              },
                                                                              style: IconButton.styleFrom(
                                                                                backgroundColor: AppColors.DARK_RED_COLOR,
                                                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                padding: EdgeInsets.zero,
                                                                                elevation: 4,
                                                                                maximumSize: Size(7.5.w, 7.5.w),
                                                                                minimumSize: Size(7.5.w, 7.5.w),
                                                                              ),
                                                                              icon: FaIcon(
                                                                                FontAwesomeIcons.solidTrashCan,
                                                                                color: AppColors.PRIMARY_COLOR,
                                                                                size: 4.w,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  dense: true,
                                                                  collapsedShape: InputBorder.none,
                                                                  shape: InputBorder.none,
                                                                  collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                                  backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
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
                                                                            childAnimationBuilder: (child) => ScaleAnimation(
                                                                              child: FadeInAnimation(child: child),
                                                                            ),
                                                                            children: [
                                                                              ///Box's Details
                                                                              if (party.productData?[i].orderType == "Box") ...[
                                                                                ///Box Type
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      S.current.boxType,
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    Text(
                                                                                      party.productData?[i].boxType == "Die Punch" ? S.current.diePunch : S.current.rsc,
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Joint Type
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      S.current.jointType,
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    Text(
                                                                                      party.productData?[i].joint != null && party.productData?[i].joint?.isNotEmpty == true ? (party.productData?[i].joint == "Glue Joint" ? S.current.glueJoint : S.current.pinJoint) : "-",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Flap Type & Sheet Box Type
                                                                                if (party.productData?[i].boxType == "RSC") ...[
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        S.current.flapType,
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 15.sp,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      Text(
                                                                                        party.productData?[i].flapType != null && party.productData?[i].flapType?.isNotEmpty == true ? (party.productData?[i].flapType == "Regular Flap" ? S.current.regularFlap : S.current.fullFlap) : "-",
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 16.sp,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.8.h),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        S.current.sheetBoxType,
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 15.sp,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      Text(
                                                                                        party.productData?[i].sheetBoxType != null && party.productData?[i].sheetBoxType?.isNotEmpty == true ? (party.productData?[i].sheetBoxType == "Single Sheet Box" ? S.current.singleSheetBox : S.current.doubleSheetBox) : "-",
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 16.sp,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.8.h),
                                                                                ],

                                                                                ///Order size [inch]
                                                                                if (party.productData?[i].boxType != "Die Punch") ...[
                                                                                  Text(
                                                                                    "${S.current.orderSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                    style: TextStyle(
                                                                                      color: AppColors.BLACK_COLOR,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 16.sp,
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                    thickness: 0.8,
                                                                                    height: 1,
                                                                                  ),
                                                                                  SizedBox(height: 0.5.h),

                                                                                  ///L, B & H
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 23.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.l}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].l ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      SizedBox(
                                                                                        width: 23.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.b}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].b ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      SizedBox(
                                                                                        width: 23.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.h}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].h ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.8.h),
                                                                                ],

                                                                                ///Die size [inch] & Ups
                                                                                if (party.productData?[i].boxType == "Die Punch") ...[
                                                                                  ///Die size [inch]
                                                                                  Text(
                                                                                    "${S.current.dieSize} (${S.current.inch}) :",
                                                                                    style: TextStyle(
                                                                                      color: AppColors.BLACK_COLOR,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 16.sp,
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                    thickness: 0.8,
                                                                                    height: 1,
                                                                                  ),
                                                                                  SizedBox(height: 0.5.h),

                                                                                  ///Deckle & Cutting
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.deckle}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].deckle ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.cutting}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].cutting ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.5.h),

                                                                                  ///Ups
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "${S.current.ups}: ",
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 15.sp,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        party.productData?[i].ups ?? "",
                                                                                        style: TextStyle(
                                                                                          color: AppColors.BLACK_COLOR,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontSize: 16.sp,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.8.h),
                                                                                ],

                                                                                ///Specification
                                                                                Text(
                                                                                  S.current.specification,
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Ply & Top Paper
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.ply}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].ply ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    if (party.productData?[i].ply != "2") ...[
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Text.rich(
                                                                                          TextSpan(
                                                                                            text: "${S.current.topPaper}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                            children: [
                                                                                              TextSpan(
                                                                                                text: party.productData?[i].topPaper ?? "",
                                                                                                style: TextStyle(
                                                                                                  color: AppColors.BLACK_COLOR,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontSize: 16.sp,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ],
                                                                                ),

                                                                                ///Paper & Flute
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.paper}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].paper ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.flute}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].flute ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Actual sheet size [inch]
                                                                                if (party.productData?[i].boxType != "Die Punch") ...[
                                                                                  Text(
                                                                                    "${S.current.actualSheetSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                    style: TextStyle(
                                                                                      color: AppColors.BLACK_COLOR,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 16.sp,
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                    thickness: 0.8,
                                                                                    height: 1,
                                                                                  ),
                                                                                  SizedBox(height: 0.5.h),

                                                                                  ///Deckle & Cutting
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.deckle}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].deckle ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(width: 2.w),
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${S.current.cutting}: ",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 15.sp,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              party.productData?[i].cutting ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(height: 0.8.h),
                                                                                ],

                                                                                ///Order Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.orderQuantity}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].orderQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production sheet size [inch]
                                                                                Text(
                                                                                  "${S.current.productionSheetSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Deckle & Cutting
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.deckle}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].productionDeckle ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.cutting}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].productionCutting ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.productionSheetQuantity}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].productionQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 1.5.h),
                                                                              ]
                                                                              ///Sheet
                                                                              else if (party.productData?[i].orderType == "Sheet") ...[
                                                                                ///Order size [inch]
                                                                                Text(
                                                                                  "${S.current.orderSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Deckle & Cutting
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.deckle}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].deckle ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.cutting}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].cutting ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Specification
                                                                                Text(
                                                                                  S.current.specification,
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Ply & Top Paper
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.ply}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].ply ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    if (party.productData?[i].ply != "2") ...[
                                                                                      SizedBox(
                                                                                        width: 35.w,
                                                                                        child: Text.rich(
                                                                                          TextSpan(
                                                                                            text: "${S.current.topPaper}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                            children: [
                                                                                              TextSpan(
                                                                                                text: party.productData?[i].topPaper ?? "",
                                                                                                style: TextStyle(
                                                                                                  color: AppColors.BLACK_COLOR,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontSize: 16.sp,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ],
                                                                                ),

                                                                                ///Paper & Flute
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.paper}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].paper ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.flute}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].flute ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Order Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.orderQuantity}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].orderQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production sheet size [inch]
                                                                                Text(
                                                                                  "${S.current.productionSheetSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Deckle & Cutting
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.deckle}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].productionDeckle ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${S.current.cutting}: ",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 15.sp,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            party.productData?[i].productionCutting ?? "",
                                                                                            style: TextStyle(
                                                                                              color: AppColors.BLACK_COLOR,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 16.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production Sheet Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.productionSheetQuantity}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].productionQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 1.5.h),
                                                                              ]
                                                                              ///Roll
                                                                              else ...[
                                                                                ///Order size [inch]
                                                                                Text(
                                                                                  "${S.current.orderSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Deckle
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.deckle}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].deckle ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Specification
                                                                                Text(
                                                                                  S.current.specification,
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Paper & Flute
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.paper}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].paper ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(width: 2.w),
                                                                                    SizedBox(
                                                                                      width: 35.w,
                                                                                      child: Text.rich(
                                                                                        TextSpan(
                                                                                          text: "${S.current.flute}: ",
                                                                                          style: TextStyle(
                                                                                            color: AppColors.BLACK_COLOR,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize: 15.sp,
                                                                                          ),
                                                                                          children: [
                                                                                            TextSpan(
                                                                                              text: party.productData?[i].flute ?? "",
                                                                                              style: TextStyle(
                                                                                                color: AppColors.BLACK_COLOR,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 16.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Order Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.orderQuantity}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].orderQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production roll size [inch]
                                                                                Text(
                                                                                  S.current.productionRollSize,
                                                                                  style: TextStyle(
                                                                                    color: AppColors.BLACK_COLOR,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 16.sp,
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: AppColors.BLACK_COLOR.withValues(alpha: 0.5),
                                                                                  thickness: 0.8,
                                                                                  height: 1,
                                                                                ),
                                                                                SizedBox(height: 0.5.h),

                                                                                ///Deckle
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${S.current.deckle}: ",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].productionDeckle ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 0.8.h),

                                                                                ///Production Roll Quantity
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      S.current.productionRollQuantity,
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 15.sp,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      party.productData?[i].orderData?[j].productionQuantity ?? "",
                                                                                      style: TextStyle(
                                                                                        color: AppColors.BLACK_COLOR,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 16.sp,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 1.5.h),
                                                                              ],
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 1.h),
                                                              ],
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
      ),
    );
  }

  ///Party Edit Bottom Sheet
  Future<void> showBottomSheetPartyEdit({
    required BuildContext context,
    required String partyId,
    required String partyName,
    required String phoneNumber,
  }) async {
    final pendingOrdersBloc = context.read<PendingOrdersBloc>();
    GlobalKey<FormState> editPartyFormKey = GlobalKey<FormState>();
    TextEditingController editPartyController = TextEditingController(text: partyName);
    TextEditingController editPhoneNumberController = TextEditingController(text: phoneNumber);

    await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w, maxHeight: 90.h, minHeight: 0.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.WHITE_COLOR,
      builder: (context) {
        final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
        return GestureDetector(
          onTap: Utils.unfocus,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: keyboardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back, Title & Save
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.SECONDARY_COLOR,
                            size: 6.w,
                          ),
                        ),
                        Text(
                          S.current.editParty,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        BlocProvider.value(
                          value: pendingOrdersBloc,
                          child: BlocConsumer<PendingOrdersBloc, PendingOrdersState>(
                            listener: (context, state) {
                              if (state is PendingOrdersEditPartySuccessState) {
                                context.pop();
                                Utils.handleMessage(message: state.successMessage);
                                pendingOrdersBloc.add(PendingOrdersGetOrdersEvent());
                              }
                              if (state is PendingOrdersEditPartyFailedState) {
                                Utils.handleMessage(message: state.failedMessage, isError: true);
                              }
                            },
                            builder: (context, state) {
                              final editPartyBloc = context.read<PendingOrdersBloc>();
                              return TextButton(
                                onPressed: () async {
                                  if (partyId.isNotEmpty) {
                                    editPartyBloc.add(
                                      PendingOrdersEditPartyClickEvent(
                                        isValidate: editPartyFormKey.currentState?.validate() == true,
                                        partyId: partyId,
                                        partyName: editPartyController.text.trim(),
                                        partyPhone: editPhoneNumberController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: IconButton.styleFrom(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: state is PendingOrdersEditPartyLoadingState && state.isLoading
                                    ? LoadingWidget(
                                        width: 8.w,
                                        height: 8.w,
                                      )
                                    : Text(
                                        S.current.save,
                                        style: TextStyle(
                                          color: AppColors.DARK_GREEN_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Divider(
                      color: AppColors.HINT_GREY_COLOR,
                      thickness: 1,
                    ),
                  ),

                  ///Edit party
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: editPartyFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Party Name
                          TextFieldWidget(
                            controller: editPartyController,
                            title: S.current.editPartyName,
                            hintText: S.current.enterPartyName,
                            validator: pendingOrdersBloc.validatePartyName,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            maxLength: 30,
                            textInputAction: TextInputAction.next,
                          ),

                          ///Phone number
                          TextFieldWidget(
                            controller: editPhoneNumberController,
                            title: S.current.editPhoneNumber,
                            hintText: S.current.enterPhoneNumber,
                            validator: pendingOrdersBloc.validatePhoneNumber,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showDeleteDialog({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
  }) async {
    final pendingOrdersBloc = context.read<PendingOrdersBloc>();

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
                  Icons.delete_forever_rounded,
                  color: AppColors.DARK_RED_COLOR,
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
                        buttonColor: AppColors.DARK_GREEN_COLOR,
                        buttonTitleColor: AppColors.PRIMARY_COLOR,
                      ),

                      ///Delete
                      BlocProvider.value(
                        value: pendingOrdersBloc,
                        child: BlocConsumer<PendingOrdersBloc, PendingOrdersState>(
                          listener: (context, state) {
                            if (state is PendingOrdersDeleteOrderSuccessState) {
                              context.pop();
                              Utils.handleMessage(message: state.successMessage);
                              context.read<PendingOrdersBloc>().add(PendingOrdersGetOrdersEvent());
                            }
                            if (state is PendingOrdersDeleteOrderFailedState) {
                              context.pop();
                              Utils.handleMessage(message: state.failedMessage, isError: true);
                            }
                          },
                          builder: (context, state) {
                            return ButtonWidget(
                              onPressed: onPressed,
                              isLoading: state is PendingOrdersDeleteOrderLoadingState && state.isLoading,
                              fixedSize: Size(30.w, 5.h),
                              buttonTitle: S.current.delete,
                              buttonColor: AppColors.DARK_RED_COLOR,
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

  Future<void> showConfirmDialog({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
  }) async {
    final pendingOrdersBloc = context.read<PendingOrdersBloc>();

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
                        value: pendingOrdersBloc,
                        child: BlocConsumer<PendingOrdersBloc, PendingOrdersState>(
                          listener: (context, state) {
                            if (state is PendingOrdersCreateJobSuccessState) {
                              context.pop();
                              Utils.handleMessage(message: state.successMessage);
                              context.read<PendingOrdersBloc>().add(PendingOrdersGetOrdersEvent());
                            }
                            if (state is PendingOrdersCreateJobFailedState) {
                              context.pop();
                              Utils.handleMessage(message: state.failedMessage, isError: true);
                            }
                          },
                          builder: (context, state) {
                            return ButtonWidget(
                              onPressed: onPressed,
                              isLoading: state is PendingOrdersCreateJobLoadingState && state.isLoading,
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
    return DateTime.now().difference(DateFormat("yyyy-MM-dd, hh:mm:ss").parse(date).toLocal()).inDays;
  }
}
