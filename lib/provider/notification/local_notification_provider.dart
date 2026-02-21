import 'package:flutter/widgets.dart';
import 'package:restaurants_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier{
  final LocalNotificationService _service;
  LocalNotificationProvider(this._service);

  static const int _dailyId = 1;

  Future<void> scheduleDailyReminder() async{
    await _service.scheduleDailyReminder(id: _dailyId);
  }

  Future<void> cancelDailyReminder() async{
    await _service.cancelReminder(_dailyId);
  }
}