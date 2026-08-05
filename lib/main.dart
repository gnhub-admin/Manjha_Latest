import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/const.dart';
import 'firebase_options.dart';
import 'languagetranslation/apptranslation.dart';
import 'shared_pref/shared_pref.dart';
import 'screens/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: themecolor, // Set your desired status bar color here
    statusBarBrightness:
        Brightness.light, // For iOS (light: white status bar icons)
    statusBarIconBrightness:
        Brightness.light, // For Android (light: white status bar icons)
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.init();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool save =
        SharedPref.get(prefKey: PrefKey.langcontry) != null ? true : false;
    return GetMaterialApp(
      locale: save == true
          ? Locale(
              SharedPref.get(prefKey: PrefKey.languagecode) ?? 'en',
              SharedPref.get(prefKey: PrefKey.langcontry) ?? 'US',
            )
          : Locale('en', 'US'),
      translations: AppTranslations(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'IN'),
        Locale('hi', 'IN'),
        Locale('or', 'IN'),
      ],
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Manjha',
      theme: ThemeData(
        scaffoldBackgroundColor: kwhite,
        appBarTheme: AppBarTheme(
          color: cartbackgroundcolor,
          iconTheme: IconThemeData(color: kblack),
        ),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.6)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    double opacity = controller.value;
    return Opacity(
      opacity: opacity,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
