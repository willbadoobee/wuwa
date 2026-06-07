class Equipment {
  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.stock,
    required this.imageUrl,
<<<<<<< HEAD
    required this.price
  });
=======
    required this.price,
  });

>>>>>>> 7036f0e (backend + update frontend & database)
  final int id;
  final String name;
  final String type;
  final String description;
  final int stock;
  final String imageUrl;
  final int price;
<<<<<<< HEAD
}
=======

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      stock: json['stock'] as int,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'stock': stock,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
>>>>>>> 7036f0e (backend + update frontend & database)
