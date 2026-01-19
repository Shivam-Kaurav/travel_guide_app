import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/repository/destinations_repo.dart';

class SeedDestinations {
  final DestinationsRepository repository;
  SeedDestinations(this.repository);
  Future<void> call(List<Destinations> destinations) {
    return repository.seedDestinations(destinations);
  }
}
