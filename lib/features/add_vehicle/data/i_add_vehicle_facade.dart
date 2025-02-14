import 'package:dartz/dartz.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/model/vehicle_model.dart';
import 'package:vehicle_list_app/general/failures/main_failure.dart';

abstract class IAddVehicleFacade {
  Future<Either<MainFailure,VehicleModel>> addVehicle({required VehicleModel vehicleModel})async{
    throw UnimplementedError('addVehicle() not implemented');
  }
  Future<Either<MainFailure,List<VehicleModel>>> fetchVehicle()async{
    throw UnimplementedError('fetchVehicle() not implemented');
  }
}