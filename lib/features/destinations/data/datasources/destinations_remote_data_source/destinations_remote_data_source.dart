import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';

abstract class DestinationsRemoteDataSource {
  Future<Map<String, Map<String, String>>> fetchDestinations();
  Future<Destinations> fetchDestinationById(String id);
}

class DestinationsRemoteDataSourceImpl implements DestinationsRemoteDataSource {
  final FirebaseFirestore firestore;
  DestinationsRemoteDataSourceImpl(this.firestore);

  @override
  Future<Map<String, Map<String, String>>> fetchDestinations() async {
    final snapshot = await firestore.collection('destinations').get();

    final Map<String, Map<String, String>> result = {};

    for (var doc in snapshot.docs) {
      final data = doc.data();

      // 🔹 Debug raw Firestore document
      print('🔥 fetchDestinations raw doc (${doc.id}): $data');

      result[doc.id] = {
        'country': data['country'] ?? data['Country'] ?? '',
        'description': data['description'] ?? data['Description'] ?? '',
      };
    }

    return result;
  }

  @override
  Future<Destinations> fetchDestinationById(String id) async {
    print('🔥 Repository fetchDestinationById for ID=$id');

    final doc = await firestore.collection('destinations').doc(id).get();

    if (!doc.exists || doc.data() == null) {
      print('⚠️ Document not found for ID=$id');
      return Destinations(
        id: id,
        name: '', // will use dummy name
        country: '',
        description: '',
        imageUrl: '',
        imageList: const [],
      );
    }

    final data = doc.data()!;
    print('🔥 Firestore raw data for $id: $data');

    return Destinations(
      id: doc.id,
      name: '', // dummy name will override
      country: data['country'] ?? data['Country'] ?? '',
      description: data['description'] ?? data['Description'] ?? '',
      imageUrl: '',
      imageList: const [],
    );
  }
}
