import 'package:flutter/widgets.dart';
import 'package:restaurants_app/data/local/local_database_service.dart';
import 'package:restaurants_app/data/model/restaurants.dart';

class LocalDatabaseProvider extends ChangeNotifier{
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  List<Restaurants>? _restaurantsList;
  List<Restaurants>? get restaurantsList => _restaurantsList;

  Restaurants? _restaurants;
  Restaurants? get restaurants => _restaurants;

  Future<void> saveRestaurantsValue(Restaurants value) async{
    try{
      final result = await _service.insertItem(value);

      _message = "Data is saved";
      notifyListeners();
      }catch(e){
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  Future<void> loadAllRestaurantsValue() async{
    try{
      _isLoading = true;
      notifyListeners();
      final result = await _service.getAllItems();
      _restaurantsList = result ?? [];
      _message = "";
    } catch(e){
      _restaurantsList = [];
      _message = "Failed to load your all data";
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRestaurantsValueById(String id) async{
    try{
      _restaurants = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch(e){
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantsValueById(String id) async{
    try{
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch(e){
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id){
    final isSameRestaurants = _restaurants?.id == id;
    return isSameRestaurants;
  }
}