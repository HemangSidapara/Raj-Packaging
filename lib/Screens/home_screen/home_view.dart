import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Screens/home_screen/bloc/home_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {},
      child: BlocProvider(
        create: (context) => HomeBloc()..add(HomeStartedEvent()),
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.SECONDARY_COLOR,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.MAIN_BORDER_COLOR.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 80,
                  )
                ],
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final items = context.read<HomeBloc>().bottomItemWidgetList;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < items.length; i++)
                        SizedBox(
                          width: 100.w / items.length,
                          child: AssetImages(
                            index: i,
                            iconName: context.read<HomeBloc>().listOfImages[i],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final homeBloc = context.read<HomeBloc>();
                return PageView(
                  controller: homeBloc.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: homeBloc.bottomItemWidgetList,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AssetImages({
    required int index,
    required String iconName,
  }) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            context.read<HomeBloc>().add(HomeChangeBottomIndexEvent(bottomIndex: index));
          },
          child: SizedBox(
            height: 12.w,
            width: 12.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconName,
                  width: 8.w,
                  color: state is HomeChangeBottomIndexState && state.bottomIndex == index ? AppColors.TERTIARY_COLOR : AppColors.WHITE_COLOR,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
