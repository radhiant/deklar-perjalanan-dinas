/*
* File : Main File
* Version : 1.0.0
* */

import 'package:deklarasi/localizations/app_localization_delegate.dart';
import 'package:deklarasi/localizations/language.dart';
// import 'package:deklarasi/screens/latihancrud/login.dart';
import 'package:deklarasi/screens/splash_screen.dart';
import 'package:deklarasi/theme/app_theme.dart';
import 'package:deklarasi/theme/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutx/themes/app_theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppTheme.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: ChangeNotifierProvider<FxAppThemeNotifier>(
        create: (context) => FxAppThemeNotifier(),
        child: MyApp(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          builder: (context, child) {
            return Directionality(
              textDirection: AppTheme.textDirection,
              child: child!,
            );
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context), // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),
          home: SplashScreen(),
        );
      },
    );
  }
}
