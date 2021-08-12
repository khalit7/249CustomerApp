// UI pages
import 'package:customer249/pages/AfterLogingInPages/book_resource_page.dart';
import 'package:customer249/pages/AfterLogingInPages/coworking_space_page.dart';
import 'package:customer249/pages/AfterLogingInPages/my_qr_page.dart';
import 'package:customer249/pages/AfterLogingInPages/scan_qr_page.dart';
import 'package:customer249/pages/AfterLogingInPages/services_page.dart';
import 'package:customer249/pages/login_page.dart';
import 'package:customer249/pages/signup_page.dart';
import 'package:customer249/pages/home_page.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/widgets/loading_page.dart';
// main package
import 'package:flutter/material.dart';
// localization
import 'lang/Localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  Future<SharedPreferences> _prefs;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
  }

  build(context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        //initialRoute: HomePage.pageName,
        home: FutureBuilder(
            future: _prefs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SharedPreferences prefrencesObject = snapshot.data;
                String jwtToken = prefrencesObject.getString("jwtToken");
                if (jwtToken == null) // new user
                  return HomePage();
                else {
                  // TODO:add jwttoken to dio intercepter
                  context.read<ApiService>().addJwtIntercepter(jwtToken);
                  return ServicesPage();
                }
              } else {
                return LoadingPage();
              }
            }),
        routes: {
          HomePage.pageName: (context) => HomePage(),
          LoginPage.pageName: (context) => LoginPage(),
          SignupPage.pageName: (context) => SignupPage(),
          ServicesPage.pageName: (context) => ServicesPage(),
          MyQRPage.pageName: (context) => MyQRPage(),
          ScanQRPage.pageName: (context) => ScanQRPage(),
          CoworkingSpacePage.pageName: (context) => CoworkingSpacePage(),
          BookResourcePage.pageName: (context) => BookResourcePage(),
        });
  }
}
