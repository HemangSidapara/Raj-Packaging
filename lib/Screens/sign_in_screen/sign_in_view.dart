import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/Screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return GestureDetector(
      onTap: () => Utils.unfocus(),
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
            child: BlocProvider(
              create: (context) => SignInBloc()..add(const SignInLoadingEvent(isLoading: false)),
              child: BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccessState) {
                    context.goNamed(Routes.homeScreen);
                  }
                },
                builder: (context, state) {
                  return ButtonWidget(
                    onPressed: () async {
                      context.read<SignInBloc>().add(
                            SignInClickedEvent(
                              phoneNumber: _phoneNumberController.text,
                              password: _passwordController.text,
                              isValidate: _signInFormKey.currentState?.validate() == true,
                            ),
                          );
                    },
                    buttonTitle: S.current.login,
                    isLoading: (state is SignInLoadingState) ? state.isLoading : false,
                  );
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h).copyWith(bottom: keyboardPadding != 0 ? 10.h : 0),
          child: Form(
            key: _signInFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Login Image
                  Image.asset(
                    AppAssets.loginImage,
                    height: 20.h,
                  ),
                  SizedBox(height: 5.h),

                  ///Phone number
                  BlocProvider(
                    create: (context) => SignInBloc()..add(SignInStartedEvent()),
                    child: Builder(builder: (context) {
                      return TextFieldWidget(
                        controller: _phoneNumberController,
                        title: S.current.phoneNumber,
                        hintText: S.current.enterPhoneNumber,
                        validator: context.read<SignInBloc>().validatePhone,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                      );
                    }),
                  ),
                  SizedBox(height: 2.h),

                  ///Password
                  BlocProvider(
                    create: (context) => SignInBloc()..add(const SignInPasswordVisibilityEvent(isPasswordVisible: false)),
                    child: BlocBuilder<SignInBloc, SignInState>(
                      buildWhen: (previous, current) => current is SignInPasswordVisibilityState,
                      builder: (context, state) {
                        return TextFieldWidget(
                          controller: _passwordController,
                          title: S.current.password,
                          hintText: S.current.enterPassword,
                          obscureText: (state is SignInPasswordVisibilityState) ? !state.isPasswordVisible : true,
                          validator: context.read<SignInBloc>().validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          maxLength: 20,
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (state is SignInPasswordVisibilityState) {
                                context.read<SignInBloc>().add(SignInPasswordVisibilityEvent(isPasswordVisible: !state.isPasswordVisible));
                              }
                            },
                            style: IconButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              state is SignInPasswordVisibilityState && state.isPasswordVisible == true ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: state is SignInPasswordVisibilityState && state.isPasswordVisible == true ? AppColors.SECONDARY_COLOR : AppColors.HINT_GREY_COLOR,
                              size: 5.5.w,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(minWidth: 12.w),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
