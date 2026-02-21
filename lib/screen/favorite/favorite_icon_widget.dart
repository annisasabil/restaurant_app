import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_app/data/model/restaurant_detail.dart';
import 'package:restaurants_app/data/model/restaurants.dart';
import 'package:restaurants_app/provider/favorite/local_database_provider.dart';
import 'package:restaurants_app/provider/favorite/favorite_icon_provider.dart';

class FavoriteIconWidget extends StatefulWidget{
  final RestaurantDetail restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget>{
  @override
  void initState(){
    super.initState();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantsValueById(widget.restaurant.id);
      final value = localDatabaseProvider.checkItemFavorite(widget.restaurant.id);
      favoriteIconProvider.isFavorited = value;
    });
  }

  @override 
  Widget build(BuildContext context){
    return IconButton(
      onPressed: () async{
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (isFavorited) {
          await localDatabaseProvider.removeRestaurantsValueById(widget.restaurant.id); 
        }else {
          await localDatabaseProvider.saveRestaurantsValue(
            Restaurants(
              id: widget.restaurant.id, 
              name: widget.restaurant.name, 
              pictureId: widget.restaurant.pictureId, 
              city: widget.restaurant.city, 
              rating: widget.restaurant.rating),
          );
        }
        favoriteIconProvider.isFavorited = !isFavorited;
        localDatabaseProvider.loadAllRestaurantsValue();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
        color: context.watch<FavoriteIconProvider>().isFavorited
            ? Colors.red
            : Colors.black,
      ),
    );
  }
}