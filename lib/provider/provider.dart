import 'package:mini_project/models/plant_model.dart';
import 'package:flutter/material.dart';

class Plant with ChangeNotifier {
  final List<PlantModel> _plants = [];
  List<PlantModel> get plants => _plants;

  void addPlant(PlantModel contact) {
    _plants.add(contact);
    notifyListeners();
  }

  void deletePlant(int index) {
    _plants.removeAt(index);
    notifyListeners();
  }
}
