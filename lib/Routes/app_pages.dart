import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Screens/sign_in_screen/sign_in_view.dart';
import 'package:raj_packaging/Screens/splash_screen/splash_bloc.dart';
import 'package:raj_packaging/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = GoRouter(
    routes: [
      ///Splash
      GoRoute(
        path: Routes.splashScreen,
        name: Routes.splashScreen,
        builder: (context, state) => BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            context.goNamed(Routes.signInScreen);
          },
          child: const SplashView(),
        ),
      ),

      ///Sign In
      GoRoute(
        path: Routes.signInScreen,
        name: Routes.signInScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            name: Routes.signInScreen,
            child: const SignInView(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
