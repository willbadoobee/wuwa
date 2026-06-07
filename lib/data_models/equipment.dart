class Equipment {
  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.stock,
    required this.imageUrl,
    required this.price
  });
  final int id;
  final String name;
  final String type;
  final String description;
  final int stock;
  final String imageUrl;
  final int price;
}