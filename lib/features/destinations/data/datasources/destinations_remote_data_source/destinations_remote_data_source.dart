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
    return {
      for (var doc in snapshot.docs)
        doc.id: {
          'country': doc.data()['country'] ?? '',
          'description': doc.data()['description'] ?? '',
        },
    };
  }

  @override
  Future<Destinations> fetchDestinationById(String id) async {
    final doc = await firestore.collection('destinations').doc(id).get();

    if (!doc.exists || doc.data() == null) {
      return Destinations(
        id: id,
        name: '', // dummy will override
        country: '', // dummy will override
        description: '', // dummy will override
        imageUrl: '',
        imageList: const [],
      );
    }

    final data = doc.data()!;
    return Destinations(
      id: doc.id,
      name: '', // dummy will override
      country: data['country'] ?? '',
      description: data['description'] ?? '',
      imageUrl: '',
      imageList: const [],
    );
  }
}
