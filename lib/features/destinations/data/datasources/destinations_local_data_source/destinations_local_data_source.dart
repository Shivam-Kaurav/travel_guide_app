import 'package:hive/hive.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';

abstract class DestinationsLocalDataSource {
  Future<void> cacheDestinations(Destinations destinations);
  Future<Destinations?> getDestinations(String id);
}

class DestinationsLocalDataSourceImpl implements DestinationsLocalDataSource {
  final Box box;
  DestinationsLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheDestinations(Destinations destinations) async {
    await box.put(destinations.id, {
      'name': destinations.name,
      'country': destinations.country,
      'description': destinations.description,
    });
  }

  @override
  Future<Destinations?> getDestinations(String id) async {
    final data = box.get(id);
    if (data == null) return null;
    return Destinations(
      country: data['country'] ?? '',
      name: data['name'] ?? '',
      imageUrl: '',
      description: data['description'] ?? '',
      imageList: [],
      id: id,
    );
  }
}
