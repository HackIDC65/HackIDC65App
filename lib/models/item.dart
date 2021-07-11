import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String? title;
  final int? price;
  final int? count;
  final String? desc;
  final String? dimensions;
  final DateTime? pickupTime;
  final List<String>? images;
  final int? reservedCount;

  Item({
    required this.id,
    this.title,
    this.price,
    this.count,
    this.desc,
    this.dimensions,
    this.pickupTime,
    this.images,
    this.reservedCount,
  });

  Item.fromJson(String id, Map<String, Object?> json)
      : this(
          id: id,
          title: json['title']! as String,
          price: json['price'] is int ? json['price'] as int : null,
          count: json['count'] is int ? json['count'] as int : null,
          desc: json['desc'] is String ? json['desc'] as String : null,
          dimensions: json['dimensions'] is String
              ? json['dimensions'] as String
              : null,
          pickupTime: json['pickupTime'] is Timestamp
              ? (json['pickupTime'] as Timestamp).toDate()
              : null,
          images: json["images"] is List
              ? (json["images"] as List).map((e) => e as String).toList()
              : null,
          reservedCount:
              json['reservedCount'] is int ? json['reservedCount'] as int : 0,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'price': price,
      'count': count,
      'desc': desc,
      'dimensions': dimensions,
      'pickupTime': pickupTime != null ? Timestamp.fromDate(pickupTime!) : null,
      'images': images,
      'reservedCount': reservedCount,
    };
  }

  bool fullyReserved() {
    final count = this.count;
    final reservedCount = this.reservedCount;
    if (count == null) {
      return reservedCount == null;
    }
    if (reservedCount == null) return false;
    return reservedCount >= count;
  }
}
