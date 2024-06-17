part of 'app_pages.dart';

class Routes {
  static const splashScreen = '/';
  static const signInScreen = '/signIn';
  static const passwordScreen = '/password';
  static const homeScreen = '/home';
  static String createOrderScreen = '${homeScreen.replaceAll("/", "")}/createOrderScreen';
  static const orderDetailsScreen = '/orderDetailsScreen';
  static const addOrderCycleScreen = '/addOrderCycleScreen';
  static const challanScreen = '/challanScreen';
  static const viewCyclesScreen = '/viewCyclesScreen';
}
