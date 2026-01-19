import 'package:flutter/material.dart';
import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';
import 'package:travel_guide_app/core/secrets.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/countries_filter_chip.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/tourist_places_list.dart';

class DestinationsScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const DestinationsScreen());
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  String? selectedCountry;
  List<Destinations> get filteredPlaces {
    if (selectedCountry == null) {
      return dummyPlaces;
    }
    return dummyPlaces
        .where((place) => place.country == selectedCountry)
        .toList();
  }

  void selectCountry(String country) {
    setState(() {
      if (selectedCountry == country) {
        selectedCountry = null;
      } else {
        selectedCountry = country;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore your favourite places...',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.purple),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CountriesFilterChip(
                  countryName: 'India',
                  isSelected: selectedCountry == 'India',
                  onTap: () {
                    selectCountry('India');
                  },
                ),
                CountriesFilterChip(
                  countryName: 'France',
                  isSelected: selectedCountry == 'France',
                  onTap: () {
                    selectCountry('France');
                  },
                ),
                CountriesFilterChip(
                  countryName: 'USA',
                  isSelected: selectedCountry == 'USA',
                  onTap: () {
                    selectCountry('USA');
                  },
                ),
                CountriesFilterChip(
                  countryName: 'Italy',
                  isSelected: selectedCountry == 'Italy',
                  onTap: () {
                    selectCountry('Italy');
                  },
                ),
                CountriesFilterChip(
                  countryName: 'Canada',
                  isSelected: selectedCountry == 'Canada',
                  onTap: () {
                    selectCountry('Canada');
                  },
                ),
              ],
            ),
          ),
          TouristPlacesList(place: filteredPlaces),
        ],
      ),
    );
  }
}
