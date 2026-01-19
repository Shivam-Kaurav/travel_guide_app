import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';

class PlacesDetailsScreen extends StatefulWidget {
  final Destinations places;

  static MaterialPageRoute route(Destinations places) => MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: context.read<DestinationsBloc>(),
      child: PlacesDetailsScreen(places: places),
    ),
  );

  const PlacesDetailsScreen({super.key, required this.places});

  @override
  State<PlacesDetailsScreen> createState() => _PlacesDetailsScreenState();
}

class _PlacesDetailsScreenState extends State<PlacesDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // 🔹 Fetch Firebase data + merge with dummy
    context.read<DestinationsBloc>().add(
      FetchDestinationDetails(
        id: widget.places.id,
        dummyDestination: widget.places,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DestinationsBloc, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationDetailsLoaded) {
              return Text(state.destination.name); // Name stays dummy
            }
            return Text(widget.places.name); // Initial fallback
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<DestinationsBloc, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DestinationDetailsLoaded) {
              final destination = state.destination;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name stays dummy
                    Text(
                      destination.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Country from Firebase
                    Text(
                      destination.country,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    // Description from Firebase
                    Text(
                      destination.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Images from dummy
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destination.imageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                destination.imageList[index],
                                fit: BoxFit.cover,
                                width: 300,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is DestinationsError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
