import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DestinationWriteDataSource {
  Future<void> storeDestinations(List<Map<String, String>> data);
}

class DestinationWriteDataSourceImpl implements DestinationWriteDataSource {
  final FirebaseFirestore firestore;
  DestinationWriteDataSourceImpl(this.firestore);

  @override
  Future<void> storeDestinations(List<Map<String, String>> data) async {
    for (final destinations in data) {
      await firestore.collection('destinations').add(destinations);
    }
  }
}
