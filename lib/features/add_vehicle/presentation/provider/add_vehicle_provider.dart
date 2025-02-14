import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/i_add_vehicle_facade.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/model/vehicle_model.dart';

class AddVehicleProvider with ChangeNotifier {
  final IAddVehicleFacade iAddVehicleFacade;

  AddVehicleProvider({required this.iAddVehicleFacade});

  final nameController = TextEditingController();
  final fuelEfficiencyController = TextEditingController();
  final manufacturingYearController = TextEditingController();
  final imageUrlController = TextEditingController();

  bool isLoading = false;
  bool noMoreData = false;
  List<VehicleModel> vehicleList = [];

  Future<void> addVehicle() async {
    final imageUrl = imageUrlController.text.trim();
    final name = nameController.text.trim();
    final fuelEfficiency = int.tryParse(fuelEfficiencyController.text.trim());
    final manufacturingYear =
        int.tryParse(manufacturingYearController.text.trim());

    if (name.isEmpty || fuelEfficiency == null || manufacturingYear == null) {
      debugPrint("Invalid input: Please enter valid values.");
      return;
    }

    final result = await iAddVehicleFacade.addVehicle(
      vehicleModel: VehicleModel(
        imageUrl: imageUrl,
        name: name,
        fuelEfficiency: fuelEfficiency,
        manufacturingYear: manufacturingYear,
        createdAt: Timestamp.now(),
      ),
    );
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('Add vehicle succesfully');
      },
    );
    clearControllers();
    notifyListeners();
  }

  Color getVehicleColor(VehicleModel vehicle) {
    int currentYear = DateTime.now().year;
    num age = currentYear - vehicle.manufacturingYear;

    if (vehicle.fuelEfficiency >= 15) {
      return age <= 5 ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }

  void clearControllers() {
    nameController.clear();
    fuelEfficiencyController.clear();
    manufacturingYearController.clear();
  }

  Future<void> fetchVehicle() async {
    if (isLoading || noMoreData) return;
    noMoreData = true;
    notifyListeners();
    final result = await iAddVehicleFacade.fetchVehicle();

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        vehicleList.addAll(success);
        log('get vehicle succesfully');
      },
    );
    noMoreData = false;
    notifyListeners();
  }

  void clearVehicleList() {
    vehicleList = [];
    notifyListeners();
  }
}
