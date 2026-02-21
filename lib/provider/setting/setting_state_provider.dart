import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurants_app/static/theme_state.dart';

class SettingStateProvider extends ChangeNotifier{

  ThemeState _themeState = ThemeState.dark;
  ThemeState get themeState => _themeState;

  set themeState(ThemeState value){
    _themeState = value;
    notifyListeners();
  }
}