import '../repository/destinations_repo.dart';
import '../entities/destinations.dart';

class GetDestinationById {
  final DestinationsRepository repository;
  GetDestinationById(this.repository);

  Future<Destinations> call(String id) {
    return repository.getDestinationById(id);
  }
}
