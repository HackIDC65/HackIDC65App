class Item {
  final String id;
  final String? title;
  final int? price;
  final int? count;
  final String? desc;
  final DateTime? pickupTime;
  bool reserved;

  Item({
    required this.id,
    this.title,
    this.price,
    this.count,
    this.desc,
    this.pickupTime,
    this.reserved = false,
  });

  Item.fromJson(String id, Map<String, Object?> json)
      : this(
    id: id,
    title: json['title']! as String,
    price: json['price'] is int ? json['price'] as int : null,
    count: json['count'] is int ? json['count'] as int : null,
    desc: json['desc'] is String ? json['desc'] as String : null,
    pickupTime: json['pickupTime'] is DateTime
        ? json['pickupTime'] as DateTime
        : null,
    reserved: json['reserved'] is bool ? json['reserved'] as bool : false,
  );
}
