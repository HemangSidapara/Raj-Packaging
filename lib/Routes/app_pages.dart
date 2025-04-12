import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/completed_screen/completed_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/create_order_screen/create_order_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/in_job_screen/in_job_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/add_screen/add_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/consume_screen/consume_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/inventory_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/stock_screen/stock_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/job_data_screen/job_data_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/pending_orders_screen/pending_orders_view.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/production_report_screen/production_report_view.dart';
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

          ///In Job
          GoRoute(
            path: Routes.inJobScreen,
            name: Routes.inJobScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.inJobScreen,
                child: const InJobView(),
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

          ///Completed
          GoRoute(
            path: Routes.completedScreen,
            name: Routes.completedScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.completedScreen,
                child: const CompletedView(),
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

          ///Job Data
          GoRoute(
            path: Routes.jobDataScreen,
            name: Routes.jobDataScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.jobDataScreen,
                child: const JobDataView(),
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

          ///Production Report
          GoRoute(
            path: Routes.productionReportScreen,
            name: Routes.productionReportScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.productionReportScreen,
                child: const ProductionReportView(),
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

          ///Inventory
          GoRoute(
            path: Routes.inventoryScreen,
            name: Routes.inventoryScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.inventoryScreen,
                child: const InventoryView(),
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
            routes: [
              ///Add
              GoRoute(
                path: Routes.addScreen,
                name: Routes.addScreen,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    name: Routes.addScreen,
                    child: const AddView(),
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

              ///Consume
              GoRoute(
                path: Routes.consumeScreen,
                name: Routes.consumeScreen,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    name: Routes.consumeScreen,
                    child: const ConsumeView(),
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

              ///Stock
              GoRoute(
                path: Routes.stockScreen,
                name: Routes.stockScreen,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    name: Routes.stockScreen,
                    child: const StockView(),
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
          ),

          ///Consume
          GoRoute(
            path: Routes.consumeHomeScreen,
            name: Routes.consumeHomeScreen,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                name: Routes.consumeHomeScreen,
                child: const ConsumeView(),
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
