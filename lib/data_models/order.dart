class Order {
  Order({
    required this.id,
    required this.equipmentName,
    required this.quantity,
    required this.total,
    required this.purchasedAt,
  });

  final int id;
  final String equipmentName;
  final int quantity;
  final int total;
  final String purchasedAt;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      equipmentName: json['equipmentName'] as String,
      quantity: json['quantity'] as int,
      total: json['total'] as int,
      purchasedAt: json['purchasedAt'] as String,
    );
  }
}
