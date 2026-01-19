part of 'destinations_bloc.dart';

@immutable
sealed class DestinationsState {}

final class DestinationsInitial extends DestinationsState {}

final class DestinationsLoading extends DestinationsState {}

final class DestinationsLoaded extends DestinationsState {
  final List<Destinations> destinations;
  DestinationsLoaded(this.destinations);
}

final class DestinationDetailsLoaded extends DestinationsState {
  final Destinations destination;
  DestinationDetailsLoaded(this.destination);
}

final class DestinationsError extends DestinationsState {
  final String message;
  DestinationsError(this.message);
}
