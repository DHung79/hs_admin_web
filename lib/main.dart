import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/logger/logger.dart';
import 'locales/i18n.dart';
import 'locales/locale_model.dart';
import 'locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/app_route_information_parser.dart';
import 'routes/app_router_delegate.dart';
import 'scroll_behavior.dart';
import 'utils/app_state_notifier.dart';

Future<SharedPreferences> prefs = SharedPreferences.getInstance();

GlobalKey globalKey = GlobalKey();

navigateTo(String route) async {
  locator<AppRouterDelegate>().navigateTo(route);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadVersion();
  setupLocator();
  return runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (_) => AppStateNotifier(),
      child: const OKToast(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouteInforParser _routeInfoParser = AppRouteInforParser();
  Locale currentLocale = supportedLocales[0];

  void setLocale(Locale value) {
    setState(() {
      currentLocale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp.router(
        theme: ThemeData(primaryColor: Colors.white),
        routeInformationParser: _routeInfoParser,
        debugShowCheckedModeBanner: false,
        title: 'Web HomeService',
        routerDelegate: locator<AppRouterDelegate>(),
        builder: (context, child) => child!,
        scrollBehavior: MyCustomScrollBehavior(),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          I18n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: currentLocale,
      );
    });
  }
}

Future<PackageInfo> loadVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  logDebug(
      ' appName: ${packageInfo.appName}  \n version: ${packageInfo.version}');

  return packageInfo;
}
