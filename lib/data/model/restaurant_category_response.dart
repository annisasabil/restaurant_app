class RestaurantCategoryResponse {
  final String name;

  RestaurantCategoryResponse({
    required this.name,
  });

  factory RestaurantCategoryResponse.fromJson(Map<String, dynamic> json){
    return RestaurantCategoryResponse(
      name: json["name"]
    );
  }
}