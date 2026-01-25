import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/core/secrets.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_write_data_source.dart/destination_write_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_remote_data_source/destinations_remote_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/repository/destinations_repo_impl.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/seed_destinations.dart';

class SeedPage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SeedPage());
  const SeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = DestinationsRepositoryImpl(
      DestinationWriteDataSourceImpl(FirebaseFirestore.instance),
      DestinationsRemoteDataSourceImpl(FirebaseFirestore.instance),
    );

    final seedUseCase = SeedDestinations(repository);

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
