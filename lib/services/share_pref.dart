import 'dart:convert';

import 'package:brush/model/loaction_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String _key = 'modelData';

  // Save MyModel data to SharedPreferences
   Future<void> saveModelData(LocationModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final modelJson = model.toJson();
    final modelJsonString = json.encode(modelJson);
    await prefs.setString(_key, modelJsonString);
  }

  // Retrieve MyModel data from SharedPreferences
   Future<LocationModel?> getModelData() async {
    final prefs = await SharedPreferences.getInstance();
    final modelJsonString = prefs.getString(_key);

    if (modelJsonString != null) {
      final modelJson = json.decode(modelJsonString);
      return LocationModel.fromJson(modelJson);
    } else {
      return null;
    }
  }
}
