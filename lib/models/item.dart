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
  bool reserved;

  Item({
    required this.id,
    this.title,
    this.price,
    this.count,
    this.desc,
    this.dimensions,
    this.pickupTime,
    this.images,
    this.reserved = false,
  });

  Item.fromJson(String id, Map<String, Object?> json)
      : this(
    id: id,
    title: json['title']! as String,
    price: json['price'] is int ? json['price'] as int : null,
    count: json['count'] is int ? json['count'] as int : null,
    desc: json['desc'] is String ? json['desc'] as String : null,
    dimensions: json['dimensions'] is String ? json['dimensions'] as String : null,
    pickupTime: json['pickupTime'] is Timestamp
        ? (json['pickupTime'] as Timestamp).toDate()
        : null,
    images: json["images"] is List ? (json["images"] as List).map((e) => e as String).toList() : null,
    reserved: json['reserved'] is bool ? json['reserved'] as bool : false,
  );
}
