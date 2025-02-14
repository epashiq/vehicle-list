import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/i_add_vehicle_facade.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/model/vehicle_model.dart';
import 'package:vehicle_list_app/general/failures/main_failure.dart';

@LazySingleton(as: IAddVehicleFacade)
class IAddVehicleImpl implements IAddVehicleFacade {
  final FirebaseFirestore firebaseFirestore;
  IAddVehicleImpl({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailure, VehicleModel>> addVehicle(
      {required VehicleModel vehicleModel}) async {
    try {
      final vehicleref = firebaseFirestore.collection('vehicle');

      final id = vehicleref.doc().id;

      final vehicle = vehicleModel.copyWith(id: id);

      await vehicleref.doc(id).set(vehicle.toMap());

      return right(vehicle);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailure, List<VehicleModel>>> fetchVehicle() async {
    try {
      Query query = firebaseFirestore
          .collection('vehicle')
          .orderBy('createdAt', descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.limit(10).get();

      if (querySnapshot.docs.length < 10) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final vehicleList = querySnapshot.docs
          .map((vehicle) =>
              VehicleModel.fromMap(vehicle.data() as Map<String, dynamic>))
          .toList();

      return right(vehicleList);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }
}
