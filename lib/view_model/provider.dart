import 'package:mini_project/models/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Plant with ChangeNotifier {
  late SharedPreferences registerdata;
  List<PlantModel> _plants = [];
  List<PlantModel> get plants => _plants;

  void addPlant(PlantModel contact) async {
    registerdata = await SharedPreferences.getInstance();
    _plants =
        (registerdata.getStringList('addplant') ?? true) as List<PlantModel>;

    _plants.add(contact);
    notifyListeners();
  }

  void deletePlant(int index) async {
    registerdata = await SharedPreferences.getInstance();
    _plants = (registerdata.remove('plant')) as List<PlantModel>;
    _plants.removeAt(index);
    notifyListeners();
  }
}
