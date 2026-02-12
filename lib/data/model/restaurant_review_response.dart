class RestaurantReviewResponse {
  final String name;
  final String review;
  final String date;

  RestaurantReviewResponse({
    required this.name,
    required this.review,
    required this.date,
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json){
    return RestaurantReviewResponse(
      name: json["name"], 
      review: json["review"], 
      date: json["date"],
    );
  }
}