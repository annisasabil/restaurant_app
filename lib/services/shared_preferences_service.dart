import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurants_app/data/model/setting.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;
  SharedPreferencesService(this._preferences);

  static const String _keyTheme = "MY_THEME";
  static const String _keyDailyReminder = "MY_DAILY_REMINDER";

  Future<void> saveSettingValue(Setting setting) async{
    try{
      await _preferences.setBool(_keyTheme, setting.isDarkMode);
      await _preferences.setBool(_keyDailyReminder, setting.dailyReminder);
    } catch(e){
      throw Exception('Shared preferences cannot save the setting value');
    }
  }

  Setting getSettingValue(){
    return Setting(
      isDarkMode: _preferences.getBool(_keyTheme) ?? false,
      dailyReminder: _preferences.getBool(_keyDailyReminder) ?? false,
    );
  }

}