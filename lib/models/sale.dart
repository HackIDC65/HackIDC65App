class Sale {
  final String id;
  final String title;
  final int itemsCount;
  final String location;
  final String userId;

  Sale({
    required this.id,
    required this.title,
    required this.itemsCount,
    required this.location,
    required this.userId,
  });

  Sale.fromJson(String id, Map<String, Object?> json)
      : this(
          id: id,
          title: json['title']! as String,
          itemsCount: json['itemsCount'] is int ? json['itemsCount'] as int : 0,
          location:
              json['location'] is String ? json['location'] as String : '',
          userId: json['userId']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'location': location,
      'userId': userId
    };
  }
}
