import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_strings.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/Screens/home_screen/bloc/home_bloc.dart';
import 'package:raj_packaging/Screens/home_screen/settings_screen/bloc/settings_bloc.dart';
import 'package:raj_packaging/Utils/in_app_update_dialog_widget.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(HomeStartedEvent()),
        ),
        BlocProvider(
          create: (context) => SettingsBloc()..add(SettingsStartedEvent()),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w).copyWith(top: 5.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomHeaderWidget(
                  title: S.current.settings,
                  titleIcon: AppAssets.settingsAnim,
                  titleIconSize: 7.w,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        if (state is HomeOnUpdateAvailableState && state.isLatestVersionAvailable) ...[
                          IconButton(
                            onPressed: () async {
                              await showUpdateDialog<SettingsBloc, SettingsState>(
                                context: context,
                                onUpdate: () async {
                                  context.read<HomeBloc>().add(HomeDownloadAndInstallStartEvent());
                                },
                                bloc: context.read<SettingsBloc>(),
                              );
                            },
                            style: IconButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero,
                              maximumSize: Size(6.w, 6.w),
                              minimumSize: Size(6.w, 6.w),
                            ),
                            icon: Icon(
                              Icons.arrow_circle_up_rounded,
                              color: AppColors.DARK_GREEN_COLOR,
                              size: 6.w,
                            ),
                          ),
                          SizedBox(width: 2.w),
                        ],
                        BlocBuilder<SettingsBloc, SettingsState>(
                          buildWhen: (previous, current) => current is SettingsCurrentVersionState,
                          builder: (context, state) {
                            return Text(
                              AppConstance.appVersion.replaceAll('1.0.0', state is SettingsCurrentVersionState ? state.currentVersion : ""),
                              style: TextStyle(
                                color: AppColors.PRIMARY_COLOR.withOpacity(0.55),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 5.h),

            ///Change Language
            Card(
              color: AppColors.TRANSPARENT,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                title: Text(
                  S.current.changeLanguage,
                  style: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR,
                backgroundColor: AppColors.LIGHT_SECONDARY_COLOR,
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                childrenPadding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 2.h),
                children: [
                  Divider(
                    color: AppColors.HINT_GREY_COLOR,
                    thickness: 1,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 50.w, minHeight: 0.w, maxWidth: 90.w, minWidth: 90.w),
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: 3,
                      children: [
                        ///English
                        BlocBuilder<SettingsBloc, SettingsState>(
                          buildWhen: (previous, current) => current is SettingsGetCurrentLocalState,
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  context.read<SettingsBloc>().add(const SettingsSetNewLocalEvent(locale: Locale("en", "US")));
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    AnimatedOpacity(
                                      opacity: state is SettingsGetCurrentLocalState && state.isGujaratiLang == false && state.isHindiLang == false ? 1 : 0,
                                      duration: const Duration(milliseconds: 300),
                                      child: Icon(
                                        Icons.done_rounded,
                                        size: 6.w,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      S.current.english,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        ///Gujarati
                        BlocBuilder<SettingsBloc, SettingsState>(
                          buildWhen: (previous, current) => previous is SettingsGetCurrentLocalState || current is SettingsGetCurrentLocalState,
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  context.read<SettingsBloc>().add(const SettingsSetNewLocalEvent(locale: Locale("gu", "IN")));
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    AnimatedOpacity(
                                      opacity: state is SettingsGetCurrentLocalState && state.isGujaratiLang ? 1 : 0,
                                      duration: const Duration(milliseconds: 300),
                                      child: Icon(
                                        Icons.done_rounded,
                                        size: 6.w,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      S.current.gujarati,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        ///Hindi
                        BlocBuilder<SettingsBloc, SettingsState>(
                          buildWhen: (previous, current) => current is SettingsGetCurrentLocalState,
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  context.read<SettingsBloc>().add(const SettingsSetNewLocalEvent(locale: Locale("hi", "IN")));
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    AnimatedOpacity(
                                      opacity: state is SettingsGetCurrentLocalState && state.isHindiLang ? 1 : 0,
                                      duration: const Duration(milliseconds: 300),
                                      child: Icon(
                                        Icons.done_rounded,
                                        size: 6.w,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      S.current.hindi,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.SECONDARY_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            ///LogOut
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsLogOutSuccessState) {
                  context.goNamed(Routes.signInScreen);
                }
              },
              builder: (context, state) {
                return ButtonWidget(
                  onPressed: () {
                    context.read<SettingsBloc>().add(SettingsLogOutClickedEvent());
                  },
                  buttonTitle: S.current.logOut,
                  isLoading: (state is SettingsLogOutLoadingState) && state.isLoading,
                );
              },
            ),
            SizedBox(height: 2.h),

            Center(
              child: Text(
                AppStrings.copyrightContext.replaceAll('2024', DateTime.now().year.toString()),
                style: TextStyle(
                  color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.55),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
