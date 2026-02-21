import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/provider/setting/shared_preferences_provider.dart';
import 'package:restaurants_app/data/model/setting.dart';

class ThemeSwitchTile extends StatelessWidget{
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context){
    final provider = context.watch<SharedPreferencesProvider>();
    final currentSetting = provider.setting ??
      Setting(
        isDarkMode: false, 
        dailyReminder: false,
      );
   
    return SwitchListTile(
      title: Text("Dark Mode",
      style: Theme.of(context).textTheme.bodySmall),
      value: currentSetting.isDarkMode, 
      onChanged: (value){
        provider.saveSettingValue(
          Setting(
            isDarkMode: value,
            dailyReminder: currentSetting.dailyReminder,
          ),
        );
      },
    );
  }
}