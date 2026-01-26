// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:travel_guide_app/core/secrets.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_local_data_source/destinations_local_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_remote_data_source/destinations_remote_data_source.dart';
import 'package:travel_guide_app/features/destinations/data/datasources/destinations_write_data_source.dart/destination_write_data_source.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/repository/destinations_repo.dart';

class DestinationsRepositoryImpl implements DestinationsRepository {
  final DestinationWriteDataSource writeDataSource;
  final DestinationsRemoteDataSource remoteDataSource;
  final DestinationsLocalDataSource localDataSource;

  DestinationsRepositoryImpl(
    this.writeDataSource,
    this.remoteDataSource,
    this.localDataSource,
  );

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

    // Keep dummy for DestinationsScreen
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
    // Try hive first
    final cached = await localDataSource.getDestinations(id);
    if (cached != null) {
      print('Loaded from hive');
      return cached;
    }
    //fallback to firebase
    print('fetching from firestore');

    final remote = await remoteDataSource.fetchDestinationById(id);
    final dummy = dummyPlaces.firstWhere((d) => d.id == id);

    final destination = Destinations(
      id: dummy.id,
      name: dummy.name,
      imageUrl: dummy.imageUrl,
      imageList: dummy.imageList,
      country: remote.country,
      description: remote.description,
    );
    //save to hive
    await localDataSource.cacheDestinations(destination);
    print('saved to hive');
    return destination;
  }
}
