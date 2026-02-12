class RestaurantMenuItem {
  final String name;

  RestaurantMenuItem({
    required this.name,
  });  

  factory RestaurantMenuItem.fromJson(Map<String, dynamic> json){
    return RestaurantMenuItem(
      name: json["name"]
    );
  }
}