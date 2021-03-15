import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Constants/AppColors.dart';
import 'Views/SplashScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp( EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'assets/language',// <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      // startLocale: Locale('ar', 'DZ'),
      child: MyApp()
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor customAppColor =  MaterialColor(0xff008840, AppColors().color );
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'ViaCourt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch:customAppColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SplashScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
    );
  }
}


