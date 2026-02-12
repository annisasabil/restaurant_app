import 'package:restaurants_app/data/model/restaurants.dart';

class RestaurantsListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurants> restaurants;

  RestaurantsListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantsListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: json["restaurants"] != null
          ? List<Restaurants>.from(json["restaurants"]!.map((x) => Restaurants.fromJson(x)))
          : <Restaurants>[],
    );
  }
}