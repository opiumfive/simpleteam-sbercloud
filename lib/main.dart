import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/const.dart';
import 'package:sbercloud_flutter/api/api_usecase.dart';
import 'package:sbercloud_flutter/ui/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'api/providers.dart';
import 'const.dart';
import 'ext.dart';
import 'models/models.dart';
import 'storage/user_preferences.dart';
import 'ui/login/login_screen.dart';
import 'ui/main/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isAndroid(context)) {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black38));
    }

    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    final materialTheme = new ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blue,
    );
    final materialDarkTheme = new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity);
    final cupertinoTheme = new CupertinoThemeData(
      brightness: brightness, // if null will use the system theme
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.blue,
        darkColor: Colors.blue,
      ),
    );

    final initialPlatform = TargetPlatform.android;

    Future<User> getUserDataAndInit() async {
      Intl.defaultLocale = await findSystemLocale();
      await initializeDateFormatting();
      return UserPreferences().getUser();
    }


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiUsecase()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: Theme(
        data:
            brightness == Brightness.light ? materialTheme : materialDarkTheme,
        child: PlatformProvider(
          initialPlatform: initialPlatform,
          settings: PlatformSettingsData(
            platformStyle: PlatformStyleData(
              web: PlatformStyle.Cupertino,
            ),
          ),
          builder: (context) => PlatformApp(
              //showPerformanceOverlay: true,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              title: 'Sbercloud',
              material: (_, __) {
                return new MaterialAppData(
                  theme: materialTheme,
                  darkTheme: materialDarkTheme,
                  themeMode: brightness == Brightness.light
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
              cupertino: (_, __) => new CupertinoAppData(
                    theme: cupertinoTheme,
                  ),
              //initialRoute: LoginScreen.ROUTE,
              home: FutureBuilder(
                  future: getUserDataAndInit(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                        else if (snapshot.data == null) return LoginScreen();
                        else Provider.of<UserProvider>(context, listen: false).setUser(snapshot.data);

                        return MainScreen();
                    }
                  }),
              routes: {
                LOGIN_ROUTE: (BuildContext context) => LoginScreen(),
                MAIN_ROUTE: (BuildContext context) => MainScreen(),
                PROFILE_ROUTE: (BuildContext context) => ProfileScreen(),
              }),
        ),
      ),
    );
  }
}
