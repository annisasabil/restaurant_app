import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/screen/home/home_screen.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
    );
  }
}