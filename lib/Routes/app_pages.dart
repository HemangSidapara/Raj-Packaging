import 'package:get/get.dart';
import 'package:raj_packaging/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = [
    ///Splash screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
  ];
}
