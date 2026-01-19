import 'package:flutter/material.dart';

class CountriesFilterChip extends StatelessWidget {
  final String countryName;
  final VoidCallback onTap;
  final bool isSelected;
  const CountriesFilterChip({
    super.key,
    required this.countryName,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ChoiceChip(
          backgroundColor: const Color.fromARGB(255, 228, 201, 233),
          selected: isSelected,
          selectedColor: const Color.fromARGB(255, 215, 227, 230),
          label: SizedBox(
            height: 20,
            width: 50,
            child: Center(
              child: Text(
                countryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
