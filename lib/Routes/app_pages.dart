import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/challan_screen/challan_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/create_order_screen/create_order_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/pending_orders_screen/pending_orders_view.dart';
import 'package:raj_packaging/Screens/home_screen/home_view.dart';
import 'package:raj_packaging/Screens/sign_in_screen/sign_in_view.dart';
import 'package:raj_packaging/Screens/splash_screen/bloc/splash_bloc.dart';
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
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            name: Routes.splashScreen,
            child: BlocProvider(
              create: (context) => SplashBloc(),
              child: const SplashView(),
            ),
            transitionDuration: transitionDuration,
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

      ///Sign In
      GoRoute(
        path: Routes.signInScreen,
        name: Routes.signInScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            name: Routes.signInScreen,
            child: const SignInView(),
            transitionDuration: transitionDuration,
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

      ///Home
      GoRoute(
        path: Routes.homeScreen,
        name: Routes.homeScreen,
        routes: [
          ///Create Order
          GoRoute(
            path: Routes.createOrderScreen,
            name: Routes.createOrderScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.createOrderScreen,
                child: const CreateOrderView(),
                transitionDuration: transitionDuration,
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

          ///Pending Orders
          GoRoute(
            path: Routes.pendingOrdersScreen,
            name: Routes.pendingOrdersScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.pendingOrdersScreen,
                child: const PendingOrdersView(),
                transitionDuration: transitionDuration,
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

          ///Challan
          GoRoute(
            path: Routes.challanScreen,
            name: Routes.challanScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.challanScreen,
                child: const ChallanView(),
                transitionDuration: transitionDuration,
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
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            name: Routes.homeScreen,
            child: const HomeView(),
            transitionDuration: transitionDuration,
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
