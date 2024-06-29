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
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
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
                    SizedBox(height: 3.h),

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
                                        title: Row(
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
                                        tilePadding: EdgeInsets.only(
                                          left: 3.w,
                                          right: 2.w,
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ///Edit
                                            IconButton(
                                              onPressed: () async {},
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
                                            SizedBox(width: 2.w),

                                            ///Delete
                                            IconButton(
                                              onPressed: () async {},
                                              style: IconButton.styleFrom(
                                                backgroundColor: AppColors.DARK_RED_COLOR,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                padding: EdgeInsets.zero,
                                                elevation: 4,
                                                maximumSize: Size(7.5.w, 7.5.w),
                                                minimumSize: Size(7.5.w, 7.5.w),
                                              ),
                                              icon: Icon(
                                                Icons.delete_forever_rounded,
                                                color: AppColors.PRIMARY_COLOR,
                                                size: 4.w,
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                                title: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    ///ItemName
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
                                                                        DateFormat("yyyy-MM-dd, hh:mm a").format(DateFormat("yyyy-MM-dd, hh:mm:ss").parse("${party.productData?[i].orderData?[j].createdDate}, ${party.productData?[i].orderData?[j].createdTime}").toLocal()),
                                                                        style: TextStyle(
                                                                          color: AppColors.BLACK_COLOR,
                                                                          fontSize: 16.sp,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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
                                                                                            ]),
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
                                                                                          ]),
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
                                                                                          ]),
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
                                                                                  color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Actual sheet size [inch]
                                                                              Text(
                                                                                "${S.current.actualSheetSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                style: TextStyle(
                                                                                  color: AppColors.BLACK_COLOR,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16.sp,
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Order Quantity & Production Quantity
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
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "${S.current.productionQuantity}: ",
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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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
                                                                                            ]),
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
                                                                                          ]),
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
                                                                                          ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 0.8.h),

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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Production size [inch]
                                                                              Text(
                                                                                "${S.current.productionSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                style: TextStyle(
                                                                                  color: AppColors.BLACK_COLOR,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16.sp,
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Order Quantity & Production Quantity
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
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "${S.current.productionQuantity}: ",
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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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
                                                                                          ]),
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
                                                                                          ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 0.8.h),

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
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Production size [inch]
                                                                              Text(
                                                                                "${S.current.productionSize.replaceAll(" :", "")} (${S.current.inch}) :",
                                                                                style: TextStyle(
                                                                                  color: AppColors.BLACK_COLOR,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16.sp,
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                color: AppColors.BLACK_COLOR.withOpacity(0.5),
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

                                                                              ///Order Quantity & Production Quantity
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
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "${S.current.productionQuantity}: ",
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
}
