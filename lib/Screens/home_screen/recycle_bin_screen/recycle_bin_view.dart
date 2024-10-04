import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecycleBinView extends StatefulWidget {
  const RecycleBinView({super.key});

  @override
  State<RecycleBinView> createState() => _RecycleBinViewState();
}

class _RecycleBinViewState extends State<RecycleBinView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w)
          .copyWith(top: 5.h),
      child: Column(
        children: [
          CustomHeaderWidget(
            title: S.current.settings,
            titleIcon: AppAssets.recycleBinIcon,
            titleIconSize: 6.5.w,
            titleIconColor: AppColors.TERNARY_COLOR,
          ),
        ],
      ),
    );
  }
}
