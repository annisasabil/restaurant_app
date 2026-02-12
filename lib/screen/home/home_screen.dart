import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/provider/home/restaurants_list_provider.dart';
import 'package:restaurants_app/screen/home/restaurants_card_widget.dart';
import 'package:restaurants_app/static/nav_route.dart';
import 'package:restaurants_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      context.read<RestaurantsListProvider>().fetchRestaurantsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Recommendation for you!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
          
        ),
      ),
      body: Consumer<RestaurantsListProvider>(
        builder: (context, value, child){
          return switch (value.resultState){
            RestaurantsListLoadingState() => const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
                strokeWidth: 3,
              ),
              ),
            RestaurantsListLoadedState(data: var restaurantList) => ListView.builder(
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                  final restaurants = restaurantList[index];

                  return RestaurantsCardWidget(
                    restaurants: restaurants, 
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        NavRoute.detailRoute.name,
                        arguments: restaurants.id
                        );
                      },
                    );
                  },
                ),
              RestaurantsListErrorState(error: var message) => Center(
                child: Text(message),
                ),
              _ => const SizedBox(),
          };
        },
      ),
    );
  }
}