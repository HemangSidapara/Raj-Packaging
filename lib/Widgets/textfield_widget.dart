import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldWidget extends StatefulWidget {
  final String? title;
  final String? hintText;
  final int? maxLength;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDisable;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIcon;
  final void Function(String value)? onFieldSubmitted;
  final double? textFieldWidth;
  final bool readOnly;
  final BoxConstraints? suffixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final Color? primaryColor;
  final Color? secondaryColor;
  final BorderRadius? borderRadius;
  final List<Widget>? titleChildren;
  final MainAxisAlignment? titleChildrenMainAxisAlignment;
  final bool? isCrossEnable;

  const TextFieldWidget({
    super.key,
    this.title,
    this.controller,
    this.validator,
    this.hintText,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.contentPadding,
    this.isDisable = false,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.onTap,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.textFieldWidth,
    this.readOnly = false,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.primaryColor,
    this.secondaryColor,
    this.borderRadius,
    this.titleChildren,
    this.titleChildrenMainAxisAlignment,
    this.isCrossEnable = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Row(
              mainAxisAlignment: widget.titleChildrenMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                      color: widget.primaryColor ?? AppColors.PRIMARY_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.titleChildren != null) ...[
                  SizedBox(width: 2.w),
                  ...widget.titleChildren!,
                ],
              ],
            ),
            SizedBox(height: 1.h),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: widget.controller,
                  validator: widget.validator,
                  focusNode: widget.focusNode,
                  style: TextStyle(
                    color: widget.secondaryColor ?? AppColors.SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                  obscureText: widget.obscureText ?? false,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.keyboardType,
                  maxLength: widget.maxLength,
                  cursorColor: widget.secondaryColor ?? AppColors.SECONDARY_COLOR,
                  enabled: widget.isDisable == false,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  onSaved: widget.onSaved,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  readOnly: widget.readOnly,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    counter: const SizedBox(),
                    counterStyle: TextStyle(color: widget.primaryColor ?? AppColors.PRIMARY_COLOR),
                    filled: true,
                    prefixIconConstraints: widget.prefixIconConstraints,
                    prefixIcon: widget.prefixIcon,
                    fillColor: widget.primaryColor ?? AppColors.PRIMARY_COLOR,
                    hintText: widget.hintText,
                    suffixIconConstraints: widget.suffixIconConstraints,
                    suffixIcon: widget.suffixIcon,
                    hintStyle: TextStyle(
                      color: widget.secondaryColor ?? AppColors.SECONDARY_COLOR.withOpacity(0.5),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    errorStyle: TextStyle(
                      color: AppColors.ERROR_COLOR,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.ERROR_COLOR,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.ERROR_COLOR,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.primaryColor ?? AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.primaryColor ?? AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.primaryColor ?? AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                    ),
                    errorMaxLines: 2,
                    isDense: true,
                    contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h).copyWith(right: 1.5.w),
                  ),
                ),
              ),
              if (widget.isCrossEnable == true) ...[
                SizedBox(width: 1.5.w),
                Padding(
                  padding: EdgeInsets.only(top: 0.3.h),
                  child: Text(
                    'x',
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 1.5.w),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
