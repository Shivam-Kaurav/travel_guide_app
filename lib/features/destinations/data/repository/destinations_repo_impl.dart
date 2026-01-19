import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/repository/destinations_repo.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_remote_data_source/destinations_remote_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_write_data_source.dart/destination_write_data_source.dart';
import 'package:travel_guide_app/core/secrets.dart'; // for dummyPlaces

class DestinationsRepositoryImpl implements DestinationsRepository {
  final DestinationWriteDataSource writeDataSource;
  final DestinationsRemoteDataSource remoteDataSource;

  DestinationsRepositoryImpl(this.writeDataSource, this.remoteDataSource);

  @override
  Future<void> seedDestinations(List<Destinations> destinations) {
    final mappedData = destinations.map((d) {
      return {'id': d.id, 'country': d.country, 'description': d.description};
    }).toList();
    return writeDataSource.storeDestinations(mappedData);
  }

  @override
  Future<List<Destinations>> getDestinations() async {
    final firebaseData = await remoteDataSource.fetchDestinations();

    return dummyPlaces.map((local) {
      final remote = firebaseData[local.id];
      return local.copyWith(
        country: remote?['country'] ?? local.country,
        description: remote?['description'] ?? local.description,
      );
    }).toList();
  }

  @override
  Future<Destinations> getDestinationById(String id) async {
    final remote = await remoteDataSource.fetchDestinationById(id);
    final dummy = dummyPlaces.firstWhere((d) => d.id == id);

    return dummy.copyWith(
      country: remote.country.isNotEmpty ? remote.country : dummy.country,
      description: remote.description.isNotEmpty
          ? remote.description
          : dummy.description,
    );
  }
}
