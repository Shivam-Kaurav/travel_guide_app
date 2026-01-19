class Destinations {
  final String id;
  final String country;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> imageList;

  Destinations({
    required this.country,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.imageList,
    required this.id,
  });

  Destinations copyWith({String? country, String? description}) {
    return Destinations(
      id: id,
      country: country ?? this.country,
      name: name,
      imageUrl: imageUrl,
      description: description ?? this.description,
      imageList: imageList,
    );
  }
}
