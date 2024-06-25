part of 'app_pages.dart';

class Routes {
  static const splashScreen = '/';
  static const signInScreen = '/signIn';
  static const passwordScreen = '/password';
  static const homeScreen = '/home';
  static String createOrderScreen = '${homeScreen.replaceAll("/", "")}/createOrderScreen';
  static String pendingOrdersScreen = '${homeScreen.replaceAll("/", "")}/pendingOrdersScreen';
  static String challanScreen = '${homeScreen.replaceAll("/", "")}/challanScreen';
}
