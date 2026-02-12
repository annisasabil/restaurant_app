import 'package:restaurants_app/data/model/restaurant_menu_item.dart';

class RestaurantMenu {
  final List<RestaurantMenuItem> foods;
  final List<RestaurantMenuItem> drinks;

  RestaurantMenu({
    required this.foods,
    required this.drinks,
  });

  factory RestaurantMenu.fromJson(Map<String, dynamic> json){
    return RestaurantMenu(
      foods: json["foods"] != null
        ? List<RestaurantMenuItem>.from(
          json["foods"].map(
            (x) => RestaurantMenuItem.fromJson(x),
          ),
        )
      : <RestaurantMenuItem>[],
      drinks: json["drinks"] != null
        ? List<RestaurantMenuItem>.from(
          json["drinks"].map(
            (x) => RestaurantMenuItem.fromJson(x),
          ),
        )
      : <RestaurantMenuItem>[],
    );
  }
}