

import 'package:beautysquare/providers/appLanguage.dart';
import 'package:beautysquare/providers/cart.dart';
import 'package:beautysquare/providers/products.dart';
import 'package:beautysquare/styles/colors.dart';
import 'package:beautysquare/util/app_localizations.dart';
import 'package:beautysquare/util/custom_pagination.dart';
import 'package:beautysquare/util/logger_util.dart';
import 'package:beautysquare/util/resource_string.dart';
import 'package:beautysquare/util/shared_Preference_manager.dart';
import 'package:beautysquare/view/login/login_pages.dart';
import 'package:beautysquare/view/splash/splashpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  var routes = <String, WidgetBuilder>{
    "/splash": (BuildContext context) =>  SplashScreen(),
    "/login": (BuildContext context) => new LoginPages(),
  };

  config();

  runApp(
      MultiProvider(
        providers: [
        ChangeNotifierProvider<AppLanguage>(
          create: (_) => appLanguage,
        ),
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
        ],

    child: Consumer<AppLanguage>(builder: (context, model, child) {
  return MaterialApp(

      title: 'Beauty Square',
      debugShowCheckedModeBanner: false,

        locale: appLanguage.appLocal,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
    localizationsDelegates: [
      // A class which loads the translations from JSON files
      AppLocalizations.delegate,
      // Built-in localization of basic text for Material widgets
      GlobalMaterialLocalizations.delegate,
      // Built-in localization for text direction LTR/RTL
      GlobalWidgetsLocalizations.delegate,
      // Built-in localization of basic text for Cupertino widgets
      GlobalCupertinoLocalizations.delegate,
    ],

        theme: ThemeData(
          primarySwatch: colorStyles['primary_dark'],
          accentColor: colorStyles['primary'],
          brightness: Brightness.light,
          primaryColor: colorStyles['primary'],
          primaryColorBrightness: Brightness.light,
          accentColorBrightness: Brightness.light,
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                fontSize: 15,
                fontFamily: 'Lato',
                color: colorStyles['black'],
              ),
              body2: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: colorStyles['black'],
              ),
              subtitle: TextStyle(
                fontSize: 17,
                fontFamily: 'Lato',
                color: colorStyles['black'],
              ),
              headline: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
              title: TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
      ),

      home: SplashScreen(),
      routes: routes,
      // ignore: missing_return
      onGenerateRoute: (settings) {
          print(settings.arguments);
       /* // if (settings.name == '/meal-detail') {
          //   return ...;
          // } else if (settings.name == '/something-else') {
          //   return ...;
          // }
          // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);*/
      },
      onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => SplashScreen(),
          );
      },
      );
     }),
      ));
}

void config() {

/** load resource strings **/
  ResourceString();
  /** load util logger **/
  LoggerUtil();
  /** set shared preference**/
  SharedPreferenceManager();
  /** set device orientation**/
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}
