import 'package:restaurants_app/data/model/restaurants.dart';

sealed class RestaurantListResultState {}

  class RestaurantsListNoneState extends RestaurantListResultState{}

  class RestaurantsListLoadingState extends RestaurantListResultState{}

  class RestaurantsListErrorState extends RestaurantListResultState{
    final String error;

    RestaurantsListErrorState(this.error);
  }

  class RestaurantsListLoadedState extends RestaurantListResultState{
    final List<Restaurants> data;

    RestaurantsListLoadedState(this.data);
  }


