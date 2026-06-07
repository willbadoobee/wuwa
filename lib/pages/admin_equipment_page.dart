import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/equipment.dart';

class AdminEquipmentPage extends StatefulWidget {
  final Equipment? equipment;
  const AdminEquipmentPage({super.key, this.equipment});
  bool get isEdit => equipment != null; // Edit/Update option if equipment data was sent as well, otherwise Create/Add option

  @override
  State<AdminEquipmentPage> createState() => _AdminEquipmentPageState();
}

class _AdminEquipmentPageState extends State<AdminEquipmentPage> {
  final _name = TextEditingController();
  final _type = TextEditingController();
  final _description = TextEditingController();
  final _stock = TextEditingController();
  final _imageUrl = TextEditingController();
  final _price = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit equipment info" : "Add new equipment"
        )
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: "Equipment Name"
            )
          ),
          TextField(
            controller: _type,
            decoration: const InputDecoration(
              labelText: "Equipment Type"
            )
          ),
          TextField(
            controller: _description,
            decoration: const InputDecoration(
              labelText: "Description"
            )
          ),
          TextField(
            controller: _stock,
            decoration: const InputDecoration(
              labelText: "Available Stock"
            )
          ),
          TextField(
            controller: _imageUrl,
            decoration: const InputDecoration(
              labelText: "Image"
            )
          ),
          TextField(
            controller: _description,
            decoration: const InputDecoration(
              labelText: "Description"
            )
          ),
          TextField(
            controller: _price,
            decoration: const InputDecoration(
              labelText: "Equipment Price"
            )
          ),
        ]
      )
    );
  }
}