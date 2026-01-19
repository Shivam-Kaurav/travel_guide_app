import 'package:flutter/material.dart';
import 'package:travel_guide_app/core/seedpage.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/explore_button.dart';
import 'package:travel_guide_app/features/destinations/presentation/widgets/home_screen_image.dart';

class HomeScreen extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomeScreen());
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Travelo',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, SeedPage.route());
            },
            icon: Icon(Icons.upload),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              'Explore New Places Without Fear Of Missing',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore place apps are mobile applications to help users navigate various destinations',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            HomeScreenImage(),
            const SizedBox(height: 20),
            ExploreButton(),
          ],
        ),
      ),
    );
  }
}
