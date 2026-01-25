import 'package:flutter/material.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/countries_filter_chip.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/tourist_places_list.dart';
import 'package:travel_guide_app/core/secrets.dart';

class DestinationsScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const DestinationsScreen());
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  String? selectedCountry;

  // Filter places based on selected country
  List<Destinations> get filteredPlaces {
    if (selectedCountry == null) {
      return dummyPlaces;
    }
    return dummyPlaces
        .where((place) => place.country == selectedCountry)
        .toList();
  }

  // Update selected country on tap
  void selectCountry(String country) {
    setState(() {
      selectedCountry = selectedCountry == country ? null : country;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of countries for filter chips
    final countries = ['India', 'France', 'USA', 'Italy', 'Canada'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore your favourite places...',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: countries.map((country) {
                return CountriesFilterChip(
                  countryName: country,
                  isSelected: selectedCountry == country,
                  onTap: () => selectCountry(country),
                );
              }).toList(),
            ),
          ),
          TouristPlacesList(place: filteredPlaces),
        ],
      ),
    );
  }
}
