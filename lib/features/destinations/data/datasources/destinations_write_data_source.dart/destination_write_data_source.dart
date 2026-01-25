import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DestinationWriteDataSource {
  Future<void> storeDestinations(List<Map<String, String>> data);
}

class DestinationWriteDataSourceImpl implements DestinationWriteDataSource {
  final FirebaseFirestore firestore;
  DestinationWriteDataSourceImpl(this.firestore);

  @override
  Future<void> storeDestinations(List<Map<String, String>> data) async {
    for (final destination in data) {
      final id = destination['id']!;
      // Use fixed doc ID instead of auto-generated
      await firestore.collection('destinations').doc(id).set(destination);
      print('Document stored for ID=$id');
    }
  }
}
