import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
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
                                        childrenPadding: EdgeInsets.only(bottom: 2.h),
                                        children: [
                                          Divider(
                                            color: AppColors.HINT_GREY_COLOR,
                                            thickness: 1,
                                          ),

                                          ///Contact Number
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${S.current.contact}: ",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.DARK_RED_COLOR,
                                                  ),
                                                ),
                                                Text(
                                                  "+91 ${party.partyPhone ?? ''}",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.SECONDARY_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///Headings
                                          Divider(
                                            color: AppColors.HINT_GREY_COLOR,
                                            thickness: 1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.current.itemName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 28.w,
                                                  child: Text(
                                                    S.current.pending,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppColors.HINT_GREY_COLOR,
                                            thickness: 1,
                                          ),

                                          ///Items
                                          ConstrainedBox(
                                            constraints: BoxConstraints(maxHeight: 60.h),
                                            child: ListView.separated(
                                              itemCount: party.productData?.length ?? 0,
                                              shrinkWrap: true,
                                              itemBuilder: (context, productIndex) {
                                                final product = party.productData?[productIndex];
                                                return ExpansionTile(
                                                  title: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      /// ItemName
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '• ',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColors.SECONDARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(width: 2.w),
                                                            Flexible(
                                                              child: Text(
                                                                product?.productName ?? '',
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
                                                    ],
                                                  ),
                                                  dense: true,
                                                  collapsedShape: InputBorder.none,
                                                  shape: InputBorder.none,
                                                  collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                                  backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                                                  iconColor: AppColors.SECONDARY_COLOR,
                                                  tilePadding: EdgeInsets.only(left: 4.w, right: 2.w),
                                                  childrenPadding: EdgeInsets.symmetric(horizontal: 3.w),
                                                  children: [
                                                    Divider(
                                                      color: AppColors.HINT_GREY_COLOR,
                                                      thickness: 1,
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ///Details
                                                          Flexible(
                                                            child: Column(
                                                              children: [],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return SizedBox(height: 1.5.h);
                                              },
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
