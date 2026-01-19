import 'package:flutter/material.dart';
import 'package:travel_guide_app/features/destinations/presentation/pages/destinations_screen.dart';

class ExploreButton extends StatelessWidget {
  const ExploreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.explore, color: Colors.blue),
      onPressed: () {
        Navigator.push(context, DestinationsScreen.route());
      },
      label: Text('Click to explore', style: TextStyle(color: Colors.blue)),
    );
  }
}
