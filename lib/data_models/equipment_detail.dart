import 'package:flutter_application/data_models/equipment.dart';

class EquipmentDetail extends Equipment {
  EquipmentDetail({
    required super.id,
    required super.name,
    required super.type,
    required super.description,
    required super.stock,
    required super.imageUrl,
    required super.price,
    // required this.
  });
}