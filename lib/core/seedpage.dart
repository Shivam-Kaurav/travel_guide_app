import 'package:flutter/material.dart';
import 'package:travel_guide_app/core/di/injection_container.dart';
import 'package:travel_guide_app/core/secrets.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/seed_destinations.dart';

class SeedPage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SeedPage());
  const SeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final seedUseCase = serviceLocator<SeedDestinations>();

    return Scaffold(
      appBar: AppBar(title: const Text("Seed Destinations")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await seedUseCase(dummyPlaces);
            print("✅ Destinations stored in Firestore with correct IDs!");
          },
          child: const Text("Upload Dummy Data"),
        ),
      ),
    );
  }
}
