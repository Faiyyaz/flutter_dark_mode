import 'package:darkmode/utilities/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  static const THEME_DARK = "THEME_DARK";
  static const THEME_LIGHT = "THEME_LIGHT";
  static const THEME_MODE = "THEME_MODE";
  SharedPreferenceHelper themePreference = SharedPreferenceHelper();
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> setDarkTheme({
    ThemeMode theme,
    bool shouldSetTheme = false,
  }) async {
    _themeMode = theme;
    if (shouldSetTheme) {
      if (theme == ThemeMode.light) {
        themePreference.set(THEME_MODE, THEME_LIGHT);
      } else if (theme == ThemeMode.dark) {
        themePreference.set(THEME_MODE, THEME_DARK);
      }
    }
    notifyListeners();
  }

  void toggleAndSaveTheme({@required BuildContext context}) {
    ThemeMode theme = themeMode;
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
    } else if (theme == ThemeMode.dark) {
      theme = ThemeMode.light;
    } else {
      Brightness brightness = MediaQuery.of(context).platformBrightness;
      if (brightness == Brightness.light) {
        theme = ThemeMode.dark;
      } else if (brightness == Brightness.dark) {
        theme = ThemeMode.light;
      }
    }

    setDarkTheme(
      shouldSetTheme: true,
      theme: theme,
    );
  }
}
