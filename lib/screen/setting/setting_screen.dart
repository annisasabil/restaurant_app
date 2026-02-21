import 'package:flutter/material.dart';
import 'package:restaurants_app/widget/daily_reminder_switch_tile.dart';
import 'package:restaurants_app/widget/theme_switch_tile.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
        style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              const ThemeSwitchTile(),
              const SizedBox(height: 24),
              const DailyReminderSwitchTile(),
          ],
        ),  
      ),
    );
  }
}