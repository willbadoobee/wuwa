import 'package:flutter/material.dart';
// import 'package:flutter_application/data_models/equipment_detail.dart';
import 'package:flutter_application/data_models/equipment.dart';

class EquipmentDetailPage extends StatefulWidget {
  final int equipmentId;
  const EquipmentDetailPage({super.key, required this.equipmentId});

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  late Future<Equipment> _future;

  @override
  void initState() {
    super.initState();

    _future = _loadInfo();
  }

  Future<Equipment> _loadInfo() async {
    // should return a function aptly named getEquipmentByID()
    // once again dummy data
    if(widget.equipmentId == 1) {
      return Equipment(
        id: 1,
        name: "Stringmaster",
        type: "Rectifier",
        description: "As the puppet palm unfurls, deadly strings are unleashed with a menacing hum.",
        stock: 5,
        imageUrl: "https://static.wikia.nocookie.net/wutheringwaves/images/1/16/Weapon_Stringmaster.png/revision/latest?cb=20240526010204",
        price: 80
      );
    }
    // if it was the other thing instead
    return Equipment(
      id: 2,
      name: "Cadenza",
      type: "Pistol",
      description: "These pistols unleash bullets with the force of thunder, tearing through the heavens like a symphony of destruction.",
      stock: 10,
      imageUrl: "https://static.wikia.nocookie.net/wutheringwaves/images/1/1c/Weapon_Cadenza.png/revision/latest?cb=20240526012627",
      price: 50
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment Details")
      ),
      body: FutureBuilder<Equipment>(
        future: _future,
        builder: (context, snapshot) {
          // loading
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          // self-explanatory, error
          if(snapshot.hasError) {
            return Center(
              child: Text("Error! ${snapshot.error}")
            );
          }

          // if no data was found
          if(!snapshot.hasData) {
            return Center(
              child: Text("No equipment data was found")
            );
          }

          // all good
          final equipment = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView( // add buy function later
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(equipment.imageUrl),
                Text(equipment.name),
                Text(equipment.type),
                Text(equipment.description),
                Text("Stock: ${equipment.stock}"),
                Text("Price: ${equipment.price} Lustrous Tides")
              ]
            )
          );
        }
      )
    );
  }
}