import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/data/api/api_services.dart';
import 'package:restaurants_app/data/local/local_database_service.dart';
import 'package:restaurants_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurants_app/provider/favorite/local_database_provider.dart';
import 'package:restaurants_app/provider/home/restaurants_list_provider.dart';
import 'package:restaurants_app/provider/main/index_nav_provider.dart';
import 'package:restaurants_app/provider/notification/local_notification_provider.dart';
import 'package:restaurants_app/screen/detail/detail_screen.dart';
import 'package:restaurants_app/screen/main/main_screen.dart';
import 'package:restaurants_app/services/local_notification_service.dart';
import 'package:restaurants_app/services/shared_preferences_service.dart';
import 'package:restaurants_app/static/nav_route.dart';
import 'package:restaurants_app/provider/setting/setting_state_provider.dart';
import 'package:restaurants_app/provider/setting/shared_preferences_provider.dart';
import 'package:restaurants_app/style/theme/restaurants_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantsListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingStateProvider(),
        ),
        Provider(
          create: (context) => SharedPreferencesService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          )
        ),
        Provider(
        create: (context) => LocalNotificationService(),
        ),
        ChangeNotifierProvider(
        create: (context) => LocalNotificationProvider(
              context.read<LocalNotificationService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SharedPreferencesProvider>().setting?.isDarkMode ?? false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: RestaurantsTheme.lightTheme,
      darkTheme: RestaurantsTheme.darkTheme,
      themeMode: isDarkMode? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavRoute.mainRoute.name,
      routes: {
        NavRoute.mainRoute.name: (context) => const MainScreen(),
        NavRoute.detailRoute.name: (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}