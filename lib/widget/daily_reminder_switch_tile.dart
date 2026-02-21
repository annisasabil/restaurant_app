import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/provider/notification/local_notification_provider.dart';
import 'package:restaurants_app/provider/setting/shared_preferences_provider.dart';

class DailyReminderSwitchTile extends StatelessWidget{
  const DailyReminderSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final prefProvider = context.watch<SharedPreferencesProvider>();
    final setting = prefProvider.setting;

    return SwitchListTile(
      title: Text("Restaurant Notification",
      style: Theme.of(context).textTheme.bodySmall),
      value: setting?.dailyReminder ?? false,
      onChanged: (value) async{
        prefProvider.saveSettingValue(
          setting!.copyWith(dailyReminder: value),
        );

      final notificationProvider = 
        context.read<LocalNotificationProvider>();

        if(value){
          await notificationProvider.scheduleDailyReminder();
        } else {
          await notificationProvider.cancelDailyReminder();
        }
      },
    );
  }
}