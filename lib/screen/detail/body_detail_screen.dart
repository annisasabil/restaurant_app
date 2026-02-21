import 'package:flutter/material.dart';
import 'package:restaurants_app/data/api/api_services.dart';
import 'package:restaurants_app/data/model/restaurant_detail.dart';

class BodyDetailScreen extends StatelessWidget{
  const BodyDetailScreen({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                ApiServices.imageUrl(restaurant.pictureId),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace){
                  return Icon(Icons.image_not_supported);
                }
              ),
            ),

            const SizedBox(height: 20),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate_sharp,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 6),
            
            Text(
              "${restaurant.city}, ${restaurant.address}",
              style: Theme.of(context).textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 24),
            
            _sectionTitle(context, "Categories"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: restaurant.categories.isEmpty
                  ?[const Text("No categories available")]
                  : restaurant.categories
                      .map(
                        (category) => Chip(
                          label: Text(category.name),
                          backgroundColor: Colors.teal[200],
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                          side: BorderSide(
                            color: Colors.teal),
                          ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 24),
                
                _sectionTitle(context, "Foods"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: restaurant.menus.foods.isEmpty
                  ?[const Text("No foods available")]
                  : restaurant.menus.foods
                      .map(
                        (food) => Chip(
                          label: Text(food.name),
                          backgroundColor: Colors.teal[200],
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                          side: BorderSide(
                            color: Colors.teal),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 24),
                
                _sectionTitle(context, "Drinks"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: restaurant.menus.drinks.isEmpty
                  ?[const Text("No drinks available")]
                  : restaurant.menus.drinks
                      .map(
                        (drink) => Chip(
                          label: Text(drink.name),
                          backgroundColor: Colors.teal[200],
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                          side: BorderSide(
                            color: Colors.teal),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 24),
                
                _sectionTitle(context, "Description"),
                const SizedBox(height: 8),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 24),

                _sectionTitle(context, "Customer Reviews"),
                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurant.customerReviews.length,
                  itemBuilder: (context, index){
                    final review = restaurant.customerReviews[index];

                    return Card(
                      color: Colors.teal.shade200,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.name,
                              style: Theme.of(context).textTheme.titleSmall
                            ),
                            const SizedBox(height: 4),
                            Text(
                              review.review,
                              style: Theme.of(context).textTheme.bodyMedium
                            ),
                            const SizedBox(height: 6),
                            Text(
                              review.date,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title){
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

      