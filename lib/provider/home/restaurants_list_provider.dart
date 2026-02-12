import 'package:flutter/widgets.dart';
import 'package:restaurants_app/data/api/api_services.dart';
import 'package:restaurants_app/static/restaurant_list_result_state.dart';

class RestaurantsListProvider extends ChangeNotifier{
  final ApiServices _apiServices;

  RestaurantsListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantsListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantsList() async{
    try{
      _resultState = RestaurantsListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();
      print('FETCH LIST START');
      print('FETCH LIST SUCCESS: ${result.restaurants.length}');


      if(result.error){
        _resultState = RestaurantsListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantsListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e){
      _resultState = RestaurantsListErrorState(e.toString());
      notifyListeners();
    }
  }
  notifyListeners();
}