class Place {
  final String name;
  final String image;
  final double rating;

  Place({required this.name, required this.image, required this.rating});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      image: json['image'],
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }
}
