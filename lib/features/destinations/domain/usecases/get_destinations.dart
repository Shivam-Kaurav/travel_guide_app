import '../repository/destinations_repo.dart';
import '../entities/destinations.dart';

class GetDestinations {
  final DestinationsRepository repository;
  GetDestinations(this.repository);

  Future<List<Destinations>> call() {
    return repository.getDestinations();
  }
}
