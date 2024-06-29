import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChallanView extends StatefulWidget {
  const ChallanView({super.key});

  @override
  State<ChallanView> createState() => _ChallanViewState();
}

class _ChallanViewState extends State<ChallanView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.unfocus,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
          child: Column(
            children: [
              ///Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: CustomHeaderWidget(
                  title: S.current.challan,
                  titleIcon: AppAssets.challanIcon,
                  onBackPressed: () {
                    context.pop();
                  },
                  titleIconSize: 10.w,
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
