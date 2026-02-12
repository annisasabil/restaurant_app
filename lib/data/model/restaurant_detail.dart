import 'package:restaurants_app/data/model/restaurant_category_response.dart';
import 'package:restaurants_app/data/model/restaurant_menu.dart';
import 'package:restaurants_app/data/model/restaurant_review_response.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final num rating;
  final List<RestaurantCategoryResponse> categories;
  final RestaurantMenu menus;
  final List<RestaurantReviewResponse> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this. pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        "id": String id,
        "name": String name,
        "description": String description,
        "city": String city,
        "address": String address,
        "pictureId": String pictureId,
        "rating": num rating,
        "categories": List categories,
        "menus": Map<String, dynamic> menus,
        "customerReviews": List customerReviews,
      } =>
        RestaurantDetail(
          id: id, 
          name: name, 
          description: description, 
          city: city, 
          address: address, 
          pictureId: pictureId, 
          rating: rating, 
          categories: categories
              .map((e) => RestaurantCategoryResponse.fromJson(
                e as Map<String, dynamic>))
              .toList(), 
          menus: RestaurantMenu.fromJson(menus),
          customerReviews: customerReviews
              .map((e) => RestaurantReviewResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      _ => throw const FormatException('Failed to load restaurant detail'),
    };
  }
}

