part of 'destinations_bloc.dart';

@immutable
sealed class DestinationsEvent {}

class FetchDestinations extends DestinationsEvent {}

class FetchDestinationDetails extends DestinationsEvent {
  final String id;
  final Destinations dummyDestination;
  FetchDestinationDetails({required this.id, required this.dummyDestination});
}
