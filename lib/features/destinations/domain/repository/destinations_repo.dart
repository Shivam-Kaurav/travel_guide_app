import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';

abstract class DestinationsRepository {
  Future<List<Destinations>> getDestinations();
  Future<void> seedDestinations(List<Destinations> destinations);
  Future<Destinations> getDestinationById(String id);
}
