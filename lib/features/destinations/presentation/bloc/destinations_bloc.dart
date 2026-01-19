import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destination_by_id.dart';
import 'package:travel_guide_app/features/destinations/domain/usecases/get_destinations.dart';

part 'destinations_event.dart';
part 'destinations_state.dart';

class DestinationsBloc extends Bloc<DestinationsEvent, DestinationsState> {
  final GetDestinations getDestinations;
  final GetDestinationById getDestinationById;

  DestinationsBloc(this.getDestinations, this.getDestinationById)
    : super(DestinationsInitial()) {
    on<FetchDestinations>((event, emit) async {
      emit(DestinationsLoading());
      try {
        final list = await getDestinations();
        emit(DestinationsLoaded(list));
      } catch (e) {
        emit(DestinationsError(e.toString()));
      }
    });

    on<FetchDestinationDetails>((event, emit) async {
      emit(DestinationsLoading());
      try {
        final destination = await getDestinationById(event.id);
        emit(DestinationDetailsLoaded(destination));
      } catch (e) {
        emit(DestinationsError(e.toString()));
      }
    });
  }
}
