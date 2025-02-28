import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/job_data_screen/bloc/job_data_bloc.dart';
import 'package:raj_packaging/Utils/app_extensions.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FlapValueWidget extends StatefulWidget {
  final JobDataBloc jobDataBloc;
  final Map<String, dynamic> data;
  final ValueChanged<bool> isCloseFromSaveCallBack;

  const FlapValueWidget({super.key, required this.jobDataBloc, required this.data, required this.isCloseFromSaveCallBack});

  @override
  State<FlapValueWidget> createState() => _FlapValueWidgetState();
}

class _FlapValueWidgetState extends State<FlapValueWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  bool isOverFlap = false;
  final GlobalKey<FormState> _aValueFormKey = GlobalKey<FormState>();
  final TextEditingController _aValueController = TextEditingController();

  bool isCloseFromSave = false;

  @override
  void initState() {
    super.initState();
    isOverFlap = widget.data["overFlap"] ?? false;
    _aValueController.text = widget.data["aValue"] ?? "";

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);
  }

  void triggerShake() {
    _shakeController.forward().whenComplete(() {
      setState(() {
        isOverFlap = false;
      });
      return _shakeController.reverse();
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _aValueController.dispose();
    super.dispose();
  }

  (bool, String) validatorFailedOverFlap() {
    double ofBValue = (widget.data["bValue"] != null && widget.data["bValue"]?.toString().isNotEmpty == true ? (widget.data["bValue"]?.toString() ?? "0.0") : "0.0").toDouble() + (widget.data["bValue"] != null && widget.data["bValue"]?.toString().isNotEmpty == true && widget.data["bValue"].toString().toDouble() > 0.0 ? 0.25 : 0.0);
    double ofCValue = (widget.data["cValue"] != null && widget.data["cValue"]?.toString().isNotEmpty == true ? (widget.data["cValue"]?.toString() ?? "0.0") : "0.0").toDouble() + (widget.data["cValue"] != null && widget.data["cValue"]?.toString().isNotEmpty == true && widget.data["cValue"].toString().toDouble() > 0.0 ? 0.25 : 0.0);
    double ofDValue = (widget.data["dValue"] != null && widget.data["dValue"]?.toString().isNotEmpty == true ? (widget.data["dValue"]?.toString() ?? "0.0") : "0.0").toDouble() + (widget.data["dValue"] != null && widget.data["dValue"]?.toString().isNotEmpty == true && widget.data["dValue"].toString().toDouble() > 0.0 ? 0.25 : 0.0);
    double productionDeckle = (widget.data["productionDeckle"]?.toString() ?? "0.0").toDouble();
    double totalOfValues = ofBValue + ofCValue + ofDValue;
    return (productionDeckle.toDouble() < totalOfValues, S.current.overFlapError.replaceAll("totalResult", totalOfValues.toStringAsFixed(2)).replaceAll("productionDeckle", productionDeckle.toStringAsFixed(2)));
  }

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return BlocProvider.value(
      value: widget.jobDataBloc,
      child: BlocBuilder<JobDataBloc, JobDataState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => Utils.unfocus(),
            child: AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeAnimation.value, 0), // Shake horizontally
                  child: child,
                );
              },
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h).copyWith(bottom: keyboardPadding),
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
                              style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              icon: Icon(Icons.close_rounded, color: AppColors.SECONDARY_COLOR, size: 6.w),
                            ),
                            Text(
                              S.current.sizeSettings,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                              ),
                            ),
                            BlocConsumer<JobDataBloc, JobDataState>(
                              listener: (context, state) {
                                if (state is JobDataUpdateAValueSuccessState) {
                                  context.pop();
                                  isCloseFromSave = true;
                                  widget.isCloseFromSaveCallBack.call(isCloseFromSave);
                                  Utils.handleMessage(message: state.successMessage);
                                  context.read<JobDataBloc>().add(const JobDataGetJobsEvent(isLoading: false));
                                }
                              },
                              builder: (context, state) {
                                return TextButton(
                                  onPressed: () {
                                    Utils.unfocus();
                                    if (_aValueFormKey.currentState?.validate() == true) {
                                      widget.jobDataBloc.add(JobDataUpdateAValueClickEvent(orderId: widget.data["orderId"], productId: widget.data["productId"], aValue: _aValueController.text.trim(), overFlap: isOverFlap));
                                    }
                                  },
                                  style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                  child: state is JobDataUpdateAValueLoadingState && state.isLoading
                                      ? SizedBox(
                                          width: 5.w,
                                          height: 5.w,
                                          child: CircularProgressIndicator(
                                            color: AppColors.SECONDARY_COLOR,
                                            strokeWidth: 2,
                                          ),
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
                      SizedBox(height: 1.h),

                      ///Over Flap
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            Switch.adaptive(
                              value: isOverFlap,
                              onChanged: (value) {
                                setState(() {
                                  isOverFlap = value;
                                  final overFlapValidation = validatorFailedOverFlap();
                                  if (value && overFlapValidation.$1) {
                                    triggerShake();
                                    Utils.handleMessage(message: overFlapValidation.$2, isError: true);
                                  }
                                });
                              },
                              activeColor: AppColors.PRIMARY_COLOR,
                              activeTrackColor: AppColors.SECONDARY_COLOR,
                              inactiveTrackColor: AppColors.PRIMARY_COLOR,
                              inactiveThumbColor: AppColors.SECONDARY_COLOR,
                              trackOutlineColor: WidgetStatePropertyAll<Color>(AppColors.SECONDARY_COLOR),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              S.current.overFlap,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      if (widget.data["aValue"] == null || widget.data["aValue"]?.toString().isEmpty == true) ...[
                        SizedBox(
                          height: 20.h,
                          child: Center(
                            child: Text(
                              S.current.noDataFound,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        ///Gaps
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ///A Value
                              SizedBox(
                                width: 85.w / 4,
                                child: Form(
                                  key: _aValueFormKey,
                                  child: TextFieldWidget(
                                    controller: _aValueController,
                                    hintText: S.current.enterA,
                                    primaryColor: AppColors.MAIN_BORDER_COLOR.withValues(alpha: 0.2),
                                    secondaryColor: AppColors.SECONDARY_COLOR,
                                    maxLength: 5,
                                    keyboardType: TextInputType.number,
                                    validator: widget.jobDataBloc.validateAValue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                                child: VerticalDivider(
                                  color: AppColors.SECONDARY_COLOR,
                                  thickness: 2,
                                ),
                              ),

                              ///B Value
                              ...dataWidget(value: widget.data["bValue"] ?? ""),

                              ///C Value
                              if (widget.data["cValue"] != null && widget.data["cValue"]?.toString().isNotEmpty == true && widget.data["cValue"]?.toString().toDouble() != 0.0) ...[
                                ...dataWidget(value: widget.data["cValue"] ?? ""),
                              ],

                              ///D Value
                              if (widget.data["dValue"] != null && widget.data["dValue"]?.toString().isNotEmpty == true && widget.data["dValue"]?.toString().toDouble() != 0.0) ...[
                                ...dataWidget(value: widget.data["dValue"] ?? ""),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        ///Rings of Gaps
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: SizedBox(
                            height: 3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///E Value
                                ...dataWidget(
                                  value: widget.data["eValue"] ?? "",
                                  isGap: false,
                                ),

                                ///F Value
                                ...dataWidget(
                                  value: widget.data["fValue"] ?? "",
                                  isGap: false,
                                ),

                                ///G Value
                                if (widget.data["gValue"] != null && widget.data["gValue"]?.toString().isNotEmpty == true && widget.data["gValue"]?.toString().toDouble() != 0.0) ...[
                                  ...dataWidget(
                                    value: widget.data["gValue"] ?? "",
                                    isGap: false,
                                  ),
                                ],

                                ///H Value
                                if (widget.data["hValue"] != null && widget.data["hValue"]?.toString().isNotEmpty == true && widget.data["hValue"]?.toString().toDouble() != 0.0) ...[
                                  ...dataWidget(
                                    value: widget.data["hValue"] ?? "",
                                    isGap: false,
                                  ),
                                ],

                                ///I Value
                                if (widget.data["iValue"] != null && widget.data["iValue"]?.toString().isNotEmpty == true && widget.data["iValue"]?.toString().toDouble() != 0.0) ...[
                                  ...dataWidget(
                                    value: widget.data["iValue"] ?? "",
                                    isGap: false,
                                  ),
                                ],

                                ///J Value
                                if (widget.data["jValue"] != null && widget.data["jValue"]?.toString().isNotEmpty == true && widget.data["jValue"]?.toString().toDouble() != 0.0) ...[
                                  ...dataWidget(
                                    value: widget.data["jValue"] ?? "",
                                    isGap: false,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> dataWidget({required String value, bool isGap = true}) {
    return [
      SizedBox(
        width: (isGap ? 72 : 50).w / 4,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.SECONDARY_COLOR,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
      if (isGap)
        SizedBox(
          height: 3.h,
          child: VerticalDivider(
            color: AppColors.SECONDARY_COLOR,
            thickness: 2,
          ),
        )
      else
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.SECONDARY_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 1.h,
            width: 2.w,
          ),
        ),
    ];
  }
}
