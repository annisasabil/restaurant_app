import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/data/api/api_services.dart';
import 'package:restaurants_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurants_app/provider/home/restaurants_list_provider.dart';
import 'package:restaurants_app/screen/detail/detail_screen.dart';
import 'package:restaurants_app/screen/main/main_screen.dart';
import 'package:restaurants_app/static/nav_route.dart';
import 'package:restaurants_app/style/theme/restaurants_theme.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: RestaurantsTheme.lightTheme,
      darkTheme: RestaurantsTheme.darkTheme,
      themeMode: ThemeMode.system,
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