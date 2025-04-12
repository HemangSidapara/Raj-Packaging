import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sizeController = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController bfController = TextEditingController();
  TextEditingController shadeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
          child: Column(
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

              ///Add
              if (getData(AppConstance.role) == AppConstance.admin) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      context.goNamed(Routes.addScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.LIGHT_SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 65.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.format_align_center_rounded,
                                  color: AppColors.SECONDARY_COLOR,
                                  size: 5.w,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  S.current.add,
                                  style: TextStyle(
                                    color: AppColors.SECONDARY_COLOR,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            AppAssets.frontIcon,
                            width: 9.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],

              ///Consume
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: ElevatedButton(
                  onPressed: () async {
                    context.goNamed(Routes.consumeScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.LIGHT_SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 65.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.takeout_dining_outlined,
                                color: AppColors.SECONDARY_COLOR,
                                size: 6.w,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                S.current.consume,
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          AppAssets.frontIcon,
                          width: 9.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Stock
              if (getData(AppConstance.role) == AppConstance.admin) ...[
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      context.goNamed(Routes.stockScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.LIGHT_SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 65.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  color: AppColors.SECONDARY_COLOR,
                                  size: 5.w,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  S.current.stock,
                                  style: TextStyle(
                                    color: AppColors.SECONDARY_COLOR,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            AppAssets.frontIcon,
                            width: 9.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
