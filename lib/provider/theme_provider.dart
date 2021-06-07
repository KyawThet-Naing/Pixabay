import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/utils/shared_pref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  checkTheme() {
    SharedPref.getData(key: 'theme').then((value) {
      if (value != null) {
        if (value == 'dark') {
          themeMode = ThemeMode.dark;
        } else {
          themeMode = ThemeMode.light;
        }
        notifyListeners();
      }
    });
  }

  changeLightTheme() {
    themeMode = ThemeMode.light;
    SharedPref.setData(key: 'theme', value: 'light');
    notifyListeners();
  }

  changeDarkTheme() {
    themeMode = ThemeMode.dark;
    SharedPref.setData(key: 'theme', value: 'dark');
    notifyListeners();
  }
}
