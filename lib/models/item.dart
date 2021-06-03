class Item {
  final String id;
  final String? title;
  final int? price;
  final int? count;
  final String? desc;
  final String? address;
  final DateTime? pickupTime;

  Item({
    required this.id,
    this.title,
    this.price,
    this.count,
    this.desc,
    this.address,
    this.pickupTime,
  });
}
