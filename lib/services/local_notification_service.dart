import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
  FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  bool _isInitialized = false;

  Future<void> init() async{
    if(_isInitialized) return;

    const androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher'
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _requestNotificationPermission();

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    _isInitialized = true;
  }

  Future<void> _requestNotificationPermission() async{
    final androidImplementation = 
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    await androidImplementation?.requestNotificationsPermission();
  }

  tz.TZDateTime _nextInstanceofElevenAM(){
    final now = tz.TZDateTime.now(tz.local);

  var scheduledDate = 
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);

    if(scheduledDate.isBefore(now)){
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleDailyReminder({required int id}) async{
    await init();

    const androidNotificationDetails = AndroidNotificationDetails(
      'restaurant_channel', 
      'Restaurant Reminder',
      channelDescription: 'Restaurant Notification',
      importance: Importance.max,
      priority: Priority.high,    
      );

    const notificationDetails = 
      NotificationDetails(android: androidNotificationDetails);
    
    final scheduledDate = _nextInstanceofElevenAM();

    print("Now      : ${tz.TZDateTime.now(tz.local)}");
    print("Schedule : $scheduledDate");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, 
      '🍽️ Restaurant', 
      'Recommendation restaurant for you', 
      scheduledDate, 
      notificationDetails, 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelReminder(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}