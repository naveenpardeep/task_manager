import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'app_pages.dart';

void main() {
  ControlOptions newinstance = ControlOptions(
      borderRadius: 3,
      appMaxWidth: 1600,
      appMinWidth: 375,
      tableHeaderColor: const Color.fromARGB(255, 93, 91, 170),
      tableHeaderLinesColor: const Color(0xff7876D9),
      colorMain: const Color(0xff7876D9),
      colorMainDark: const Color.fromARGB(255, 61, 60, 107),
      colorMainLight: const Color(0xffEEEEFA),
      colorMainLighter: const Color(0xffEEEEFA),
      colorMainText: const Color.fromRGBO(255, 255, 255, 1),
      colorText: const Color.fromRGBO(30, 30, 30, 1),
      colorInverted: const Color.fromRGBO(255, 255, 255, 1),
      colorSecondary: const Color.fromRGBO(123, 181, 0, 1),
      colorGrey: const Color.fromRGBO(189, 189, 189, 1),
      colorGreyLight: const Color.fromRGBO(238, 238, 238, 1),
      colorGreyLighter: const Color.fromRGBO(248, 248, 248, 1),
      colorGreyDark: const Color.fromRGBO(136, 136, 136, 1),
      colorGreyDarker: const Color.fromRGBO(51, 51, 51, 1),

      // colorWhite: const Color.fromRGBO(255, 255, 255, 1),
      colorWarning: const Color(0xFFF7B217),
      colorError: const Color(0xFFFF0000),
      gradients: {
        'main': [const Color.fromRGBO(250, 250, 250, 1), const Color.fromRGBO(146, 120, 255, 1)],
        'header': [const Color.fromRGBO(81, 67, 142, 1), const Color.fromRGBO(146, 120, 255, 1)],
      });
  ControlOptions.instance = newinstance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NsgDataControllerMode.defaultDataControllerMode =
    //     const NsgDataControllerMode(storageType: NsgDataStorageType.local);
    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      defaultTransition: Transition.noTransition,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 14.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.20,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.20,
          ),
          headline1: TextStyle(
            fontSize: 20.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            fontSize: 18.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            height: 1.40,
            letterSpacing: 1.0,
          ),
          headline3: TextStyle(
            fontSize: 18.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
          headline4: TextStyle(
            fontSize: 14.0,
            color: ControlOptions.instance.colorText,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
          button: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
            height: 1.40,
            letterSpacing: 1.0,
          ),
          caption: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(33, 32, 30, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 1.40,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru')],
      locale: const Locale('ru'),
    );
  }
}
