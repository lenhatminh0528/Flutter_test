import 'package:biocare_flutter/constant/Colors.dart';
import 'package:biocare_flutter/screens/baseRulerScreen.dart';
import 'package:biocare_flutter/screens/sign_in.dart';
import 'package:biocare_flutter/widgets/pinCodeScrene/pinCode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeApp = ThemeData(
    primarySwatch: AppColor.primaryColor,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioCare',
      theme: themeApp,
      initialRoute: PinCodeScreen.routeName,
      routes: {
        SignInView.routeName: (ctx) => const SignInView(),
        BaseRulerScreen.routeName: (ctx) => const BaseRulerScreen(),
        PinCodeScreen.routeName: ((ctx) => const PinCodeScreen()),
      },
    );
  }
}
