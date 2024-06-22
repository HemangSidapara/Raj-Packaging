import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/app_fonts.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Routes/app_pages.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

late BuildContext globalContext;

void main() {
  GetStorage.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.SECONDARY_COLOR,
            primaryColor: AppColors.PRIMARY_COLOR,
            fontFamily: AppFonts.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            datePickerTheme: DatePickerThemeData(headerBackgroundColor: AppColors.SECONDARY_COLOR),
            useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: AppColors.DARK_GREEN_COLOR,
            ),
          ),
          locale: Locale(
            getData(AppConstance.languageCode) != null && getData(AppConstance.languageCode) != "" ? getData(AppConstance.languageCode) : "en",
            getData(AppConstance.languageCountryCode) != null && getData(AppConstance.languageCountryCode) != "" ? getData(AppConstance.languageCountryCode) : "US",
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: AppPages.pages,
        );
      },
    );
  }
}
