import 'package:darkmode/screens/splash_screen.dart';
import 'package:darkmode/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  ThemeProvider themeProvider = ThemeProvider();
  String theme = await themeProvider.themePreference.getTheme();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(
        themeProvider: themeProvider,
        theme: theme,
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final ThemeProvider themeProvider;
  final String theme;

  MyApp({this.themeProvider, this.theme});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCurrentAppTheme() {
    String theme = widget.theme;
    ThemeMode themeMode;
    if (theme == null) {
      themeMode = ThemeMode.system;
    } else if (theme == ThemeProvider.THEME_LIGHT) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    widget.themeProvider.setDarkTheme(theme: themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return widget.themeProvider;
          },
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: widget.themeProvider.themeMode,
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.white,
              appBarTheme: AppBarTheme(
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.black,
              appBarTheme: AppBarTheme(
                brightness: Brightness.dark,
              ),
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
