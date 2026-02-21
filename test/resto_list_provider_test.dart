import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurants_app/data/api/api_services.dart';
import 'package:restaurants_app/data/model/restaurants_list_response.dart';
import 'package:restaurants_app/provider/home/restaurants_list_provider.dart';
import 'package:restaurants_app/static/restaurant_list_result_state.dart';
import 'package:restaurants_app/data/model/restaurants.dart';

class RestoListProviderTest extends Mock implements ApiServices {}

void main(){
  late RestoListProviderTest restoListProviderTest;
  late RestaurantsListProvider provider;

  setUp((){
    restoListProviderTest = RestoListProviderTest();
    provider = RestaurantsListProvider(restoListProviderTest);
  });

  // state awal provider harus didefinisikan
  test('Initial state should be RestaurantsListNoneState', (){
    expect(provider.resultState, isA<RestaurantListResultState>());
  });

  // Harus mengembalikan daftar restoran ketika pengambilan data API berhasil
  test('Should return restaurant list when API call success', () async{
    final fakeRestaurantsList = [
      Restaurants(
        id: 'id', 
        name: 'name', 
        pictureId: 'pictureId', 
        city: 'city', 
        rating: 4.5,
      ),
    ];

    final fakeResponse = RestaurantsListResponse(
      error: false, 
      message: 'success', 
      count: 1, 
      restaurants: fakeRestaurantsList
    );

    when(() => restoListProviderTest.getRestaurantList())
        .thenAnswer((_) async => fakeResponse);

    await provider.fetchRestaurantsList();
    expect(provider.resultState, isA<RestaurantsListLoadedState>());

    final state = provider.resultState as RestaurantsListLoadedState;
    expect(state.data.length, 1);
    expect(state.data.first.name, 'name');
  });

  // Harus mengembalikan kesalahan ketika pengambilan API gagal
  test('Should return error state when API call fails', () async{
    final fakeResponse = RestaurantsListResponse(
      error: true, 
      message: 'Failed to load', 
      count: 0, 
      restaurants: []
    );

    when(() => restoListProviderTest.getRestaurantList())
        .thenAnswer((_) async => fakeResponse);
    
    await provider.fetchRestaurantsList();

    expect(provider.resultState, isA<RestaurantsListErrorState>());

    final state = provider.resultState as RestaurantsListErrorState;
    expect(state.error, 'Failed to load');
  });
}