class Item {
  final String id;
  final String title;
  final int price;
  final String desc;
  final DateTime pickupTime;

  Item({
    required this.id,
    required this.title,
    required this.price,
    this.desc = '',
    DateTime? pickupTime,
  }) : this.pickupTime = pickupTime ?? DateTime.now();
}
