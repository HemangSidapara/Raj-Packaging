part of 'app_pages.dart';

class Routes {
  static const splashScreen = '/';
  static const signInScreen = '/signIn';
  static const passwordScreen = '/password';
  static const homeScreen = '/home';
  static String createOrderScreen = '${homeScreen.replaceAll("/", "")}/createOrderScreen';
  static String pendingOrdersScreen = '${homeScreen.replaceAll("/", "")}/pendingOrdersScreen';
  static String inJobScreen = '${homeScreen.replaceAll("/", "")}/inJobScreen';
  static String completedScreen = '${homeScreen.replaceAll("/", "")}/completedScreen';
  static String jobDataScreen = '${homeScreen.replaceAll("/", "")}/jobDataScreen';
}
