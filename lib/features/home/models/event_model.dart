class CulturalEvent {
  final String id;
  final String title;
  final String imageUrl;
  final String? location;
  final DateTime? date;

  const CulturalEvent({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.location,
    this.date,
  });

  factory CulturalEvent.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return CulturalEvent(
      id: id,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      location: map['location'],
    );
  }
}