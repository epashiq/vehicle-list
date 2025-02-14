import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/provider/add_vehicle_provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/widgets/vehicle_card_widget.dart';

class DisplayVehicleScreen extends StatefulWidget {
  const DisplayVehicleScreen({super.key});

  @override
  State<DisplayVehicleScreen> createState() => _DisplayVehicleScreenState();
}

class _DisplayVehicleScreenState extends State<DisplayVehicleScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final addVehicleProvider =
        Provider.of<AddVehicleProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addVehicleProvider.fetchVehicle();
      addVehicleProvider.clearVehicleList();
    });
    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(!addVehicleProvider.isLoading&&!addVehicleProvider.noMoreData){
          addVehicleProvider.fetchVehicle();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
      ),
      body: Consumer<AddVehicleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.vehicleList.isEmpty) {
            return const Center(
              child: Text(
                'No vehicles added yet',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchVehicle(),
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: provider.vehicleList.length,
              itemBuilder: (context, index) {
                final vehicle = provider.vehicleList[index];
                return VehicleCardWidget(
                  vehicle: vehicle,
                  color: provider.getVehicleColor(vehicle),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
