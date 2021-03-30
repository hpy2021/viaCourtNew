import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/Constants/AppConstants.dart';
import 'package:my_app/Constants/Applocalization.dart';
import 'package:my_app/Constants/FirebaseMessagingService.dart';

import 'Constants/AppColors.dart';
import 'Views/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  FirebaseMessagingServiceInitialiation().init();
  runApp(
    // EasyLocalization(
    //     supportedLocales: [Locale('en', ''), Locale('ar', ''),Locale('it', '')],
    //     path: 'assets/language',
    //     // saveLocale: true,
    //     // useFallbackTranslations: true,
    //     //
    //     // fallbackLocale: Platform.localeName.contains("en") ? Locale("en", "US")
    //     //   : Locale('ar', 'DZ'),
    //     // <-- change patch to your
    //     // fallbackLocale: Locale('en', 'US'),
    //     // startLocale: Platform.localeName.contains("en")
    //     //     ? Locale("en", "US")
    //     //     : Locale('ar', 'DZ'),
    //     // useOnlyLangCode: true,
    //     // startLocale:        //     ? Locale("en", "US")
    //     // ,
    //     startLocale: Locale('en', ''),
    //     child:
        MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MaterialColor customAppColor = MaterialColor(0xff008840, AppColors().color);
    return MaterialApp(

      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'ViaCourt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: customAppColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // EasyLocalization.of(context).delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            print("has the same alangugae");
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      supportedLocales: [Locale('en', ''), Locale('ar', ''),Locale('it', '')],
      // locale: EasyLocalization.of(context).locale,
    );
  }
}
