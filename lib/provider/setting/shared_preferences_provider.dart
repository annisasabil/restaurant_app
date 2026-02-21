import 'package:flutter/widgets.dart';
import 'package:restaurants_app/data/model/setting.dart';
import 'package:restaurants_app/services/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier{
  final SharedPreferencesService _service;
  SharedPreferencesProvider(this._service){
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting value) async{
    try{
      await _service.saveSettingValue(value);
      _setting = value;
      _message = 'Theme saved successfully';
    } catch(e){
      _message = 'Failed to save Theme';
    }
    notifyListeners();
  }

  void getSettingValue(){
    try{
      _setting = _service.getSettingValue();
      _message = 'Theme loaded successfully';
    } catch(e){
      _message = 'Failed to load theme';
    }
    notifyListeners();
  }
}