import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveSizer(builder: (context, orientation, screenType) {
        return Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                Utils.handleMessage(context: context);
              },
              child: Text('click'),
            ),
          ),
        );
      }),
    );
  }
}
