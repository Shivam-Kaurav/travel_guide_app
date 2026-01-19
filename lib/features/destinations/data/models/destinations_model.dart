import 'package:travel_guide_app/features/destinations/domain/entities/destinations.dart';

class DestinationsModel extends Destinations {
  DestinationsModel({
    required super.id,
    required super.country,
    required super.name,
    required super.imageUrl,
    required super.description,
    required super.imageList,
  });
  factory DestinationsModel.fromJson(Map<String, dynamic> json) {
    return DestinationsModel(
      id: json['id'],
      country: json['country'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      imageList: List<String>.from(json['images']),
    );
  }
}
