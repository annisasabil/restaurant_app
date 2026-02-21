class Restaurants {
  final String id;
  final String name;
  final String pictureId;
  final String city;
  final num rating;


  Restaurants({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        "id": String id,
        "name": String name,
        "pictureId": String pictureId,
        "city": String city,
        "rating": num rating,
      } =>
        Restaurants(
          id: id, 
          name: name, 
          pictureId: pictureId, 
          city: city, 
          rating: rating,
        ),
      _ => throw const FormatException('Failed to load restaurant data.'),
    };
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      "id": id, 
      "name": name, 
      "pictureId": pictureId, 
      "city": city, 
      "rating": rating,
    };
  }
}