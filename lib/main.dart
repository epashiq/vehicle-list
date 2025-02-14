import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/data/i_add_vehicle_facade.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/provider/add_vehicle_provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/view/add_vehicle_screen.dart';
import 'package:vehicle_list_app/general/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AddVehicleProvider(iAddVehicleFacade: sl<IAddVehicleFacade>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AddVehicleScreen(),
      ),
    );
  }
}
