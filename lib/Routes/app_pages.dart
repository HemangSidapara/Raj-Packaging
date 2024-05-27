import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = GoRouter(
    routes: [
      ///Splash
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) => const SplashView(),
      ),
    ],
  );
}
