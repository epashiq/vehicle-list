import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/provider/add_vehicle_provider.dart';
import 'package:vehicle_list_app/features/add_vehicle/presentation/view/display_vehicle_screen.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final addVehicleProvider =
        Provider.of<AddVehicleProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      addVehicleProvider.addVehicle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.directions_car_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DisplayVehicleScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'Add Vehicle Photo',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: addVehicleProvider.nameController,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Name',
                    hintText: 'e.g., Toyota Camry',
                    prefixIcon: const Icon(Icons.directions_car),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: addVehicleProvider.fuelEfficiencyController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Fuel Efficiency',
                    hintText: 'Enter km/l',
                    prefixIcon: const Icon(Icons.local_gas_station),
                    suffixText: 'km/l',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter fuel efficiency';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: addVehicleProvider.manufacturingYearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Manufacturing Year',
                    hintText: 'e.g., 2022',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter manufacturing year';
                    }
                    final year = int.tryParse(value);
                    if (year == null) {
                      return 'Please enter a valid year';
                    }
                    final currentYear = DateTime.now().year;
                    if (year < 1900 || year > currentYear) {
                      return 'Please enter a year between 1900 and $currentYear';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addVehicleProvider.addVehicle();
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisplayVehicleScreen(),
                        ));
                  },
                  child: const Text(
                    'Add Vehicle',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


