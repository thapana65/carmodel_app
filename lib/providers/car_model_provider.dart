import 'package:flutter/material.dart';
import 'package:car_model_app/models/model.dart';

class CarModelProvider with ChangeNotifier {
  List<CarModel> _cars = [];

  List<CarModel> get cars => _cars;

  void addCar(CarModel car) {
    _cars.add(CarModel(
      id: car.id,
      brand: car.brand,
      model: car.model,
      year: car.year,
      category: car.category,
      price: car.price,
      color: car.color,
      launchDate: car.launchDate,
      imageUrl: car.imageUrl,
      createdAt: DateTime.now(),
    ));
    notifyListeners();
  }

  void removeCar(int index) {
    _cars.removeAt(index);
    notifyListeners();
  }

  void editCar(int index, CarModel UpdateCar) {
    _cars[index] = UpdateCar;
    notifyListeners();
  }
}
