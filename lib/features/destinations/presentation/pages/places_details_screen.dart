import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';

class PlacesDetailsScreen extends StatefulWidget {
  final Destinations place;

  static MaterialPageRoute route(Destinations place) => MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: context.read<DestinationsBloc>(),
      child: PlacesDetailsScreen(place: place),
    ),
  );

  const PlacesDetailsScreen({super.key, required this.place});

  @override
  State<PlacesDetailsScreen> createState() => _PlacesDetailsScreenState();
}

class _PlacesDetailsScreenState extends State<PlacesDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Fire the event to fetch Firestore data
    context.read<DestinationsBloc>().add(
      FetchDestinationDetails(
        id: widget.place.id,
        dummyDestination: widget.place,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Place Details")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<DestinationsBloc, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DestinationDetailsLoaded) {
              final destination = state.destination;

              // 🔹 Debug prints in UI build
              print('🔥 UI received DestinationDetailsLoaded');
              print('Name: ${destination.name}');
              print('Country: ${destination.country}');
              print('Description: ${destination.description}');

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name stays dummy
                    Text(
                      widget.place.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Country from Firestore
                    Text(
                      destination.country,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    // Description from Firestore
                    Text(
                      destination.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is DestinationsError) {
              return Center(child: Text(state.message));
            }

            // Initial loading fallback
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
