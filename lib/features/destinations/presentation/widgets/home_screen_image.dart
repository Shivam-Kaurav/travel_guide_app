import 'package:flutter/material.dart';

class HomeScreenImage extends StatelessWidget {
  const HomeScreenImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
          fit: BoxFit.cover,
          cacheWidth: screenWidth.toInt(),
          cacheHeight: 300,
        ),
      ),
    );
  }
}
