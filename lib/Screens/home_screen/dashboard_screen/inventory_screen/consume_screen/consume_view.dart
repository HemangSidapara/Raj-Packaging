import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/consume_screen/bloc/consume_bloc.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConsumeView extends StatefulWidget {
  const ConsumeView({super.key});

  @override
  State<ConsumeView> createState() => _ConsumeViewState();
}

class _ConsumeViewState extends State<ConsumeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConsumeBloc()..add(ConsumeStartedEvent()),
      child: GestureDetector(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<ConsumeBloc, ConsumeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.consume,
                        titleIcon: AppAssets.inventoryIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 1.h),
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
