import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/recycle_bin_screen/bloc/recycle_bin_bloc.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecycleBinView extends StatefulWidget {
  const RecycleBinView({super.key});

  @override
  State<RecycleBinView> createState() => _RecycleBinViewState();
}

class _RecycleBinViewState extends State<RecycleBinView> {
  final TextEditingController _searchPartyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecycleBinBloc()..add(RecycleBinStartedEvent()),
      child: BlocBuilder<RecycleBinBloc, RecycleBinState>(
        builder: (context, state) {
          final recycleBinBloc = context.read<RecycleBinBloc>();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 2.h),
                child: CustomHeaderWidget(
                  title: S.current.recycleBin,
                  titleIcon: AppAssets.recycleBinIcon,
                  titleIconSize: 6.5.w,
                  titleIconColor: AppColors.TERTIARY_COLOR,
                ),
              ),

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
                      await recycleBinBloc.searchPartyName(_searchPartyController.text);
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
                    await recycleBinBloc.searchPartyName(_searchPartyController.text);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 1.h),

              ///Orders List
              if (state is RecycleBinGetOrdersLoadingState && state.isLoading == true)
                const Expanded(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                )
              else if (recycleBinBloc.searchedOrdersList.isEmpty)
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
                      itemCount: recycleBinBloc.searchedOrdersList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                      itemBuilder: (context, index) {
                        final party = recycleBinBloc.searchedOrdersList[index];
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
                                  tilePadding: EdgeInsets.only(
                                    left: 3.w,
                                    right: Device.screenType == ScreenType.tablet ? 0.5.w : 2.w,
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
                                                              ],
                                                            ),
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
    );
  }

  int? daysGone({required String date}) {
    return DateTime.now().difference(DateFormat("yyyy-MM-dd, hh:mm:ss").parse(date).toLocal()).inDays;
  }
}
