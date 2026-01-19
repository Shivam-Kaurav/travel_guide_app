import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/presentation/pages/places_details_screen.dart';
import 'package:travel_guide_app/features/destinations/presentation/bloc/destinations_bloc.dart';

class TouristPlacesList extends StatelessWidget {
  final List<Destinations> place;
  const TouristPlacesList({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: place.length,
        itemBuilder: (context, index) {
          final touristPlace = place[index];
          return GestureDetector(
            onTap: () {
              // Navigate to PlacesDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: context.read<DestinationsBloc>(),
                    child: PlacesDetailsScreen(places: touristPlace),
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.network(
                      touristPlace.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(touristPlace.name),
                subtitle: Text(touristPlace.country),
              ),
            ),
          );
        },
      ),
    );
  }
}
