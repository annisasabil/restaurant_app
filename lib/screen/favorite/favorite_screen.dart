import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/provider/favorite/local_database_provider.dart';
import 'package:restaurants_app/screen/home/restaurants_card_widget.dart';
import 'package:restaurants_app/static/nav_route.dart';

class FavoriteScreen extends StatefulWidget{
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurantsValue();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          if(value.isLoading){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
                strokeWidth: 3,
              ),
            );
          }

          if(value.message.isNotEmpty){
            return Center(
              child: Text(
                value.message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          final favoriteList = value.restaurantsList ?? [];

          if(favoriteList == null || favoriteList.isEmpty){
            return const Center(
              child: Text("No Favorited"),
            );
          }
          return switch(favoriteList.isNotEmpty){
            true => ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index){
                final restaurants = favoriteList[index];

                return RestaurantsCardWidget(
                  restaurants: restaurants, 
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      NavRoute.detailRoute.name,
                      arguments: restaurants.id,
                    );
                  },
                );
              },
            ),
          _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Favorited"),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}
