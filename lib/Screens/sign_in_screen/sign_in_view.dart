import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return GestureDetector(
      onTap: () => Utils.unfocus,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100.w, 10.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.8.h),
            child: Center(
              child: Text(
                S.current.login,
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Material(
          color: AppColors.SECONDARY_COLOR,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: keyboardPadding != 0 ? 2.h : 5.h),
            child: ButtonWidget(
              onPressed: () async {
                Utils.unfocus();
              },
              buttonTitle: S.current.login,
              isLoading: false,
            ),
          ),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
