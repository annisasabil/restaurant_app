import 'dart:convert';

import 'package:restaurants_app/data/model/restaurants_list_response.dart';
import 'package:restaurants_app/data/model/restaurant_detail_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String _image = '$_baseUrl/images/small/';

  Future<RestaurantsListResponse> getRestaurantList() async{
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if(response.statusCode == 200){
      return RestaurantsListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
  
    if(response.statusCode == 200){
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  static String imageUrl(String pictureId){
    return '$_image$pictureId';
  }
}