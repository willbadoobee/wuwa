<<<<<<< HEAD
import 'package:flutter/material.dart';
// import 'package:flutter_application/data_models/equipment_detail.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)
import 'package:flutter_application/data_models/equipment.dart';

class EquipmentDetailPage extends StatefulWidget {
  final int equipmentId;
  const EquipmentDetailPage({super.key, required this.equipmentId});

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  late Future<Equipment> _future;
<<<<<<< HEAD
=======
  int quantityToBuy = 1;
  bool isLoading = false;
  String? message;
>>>>>>> 7036f0e (backend + update frontend & database)

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD

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
=======
    _future = profile_api.getEquipmentById(widget.equipmentId);
  }

  Future<void> handleBuy(Equipment equipment) async {
    if (quantityToBuy <= 0 || quantityToBuy > equipment.stock) {
      setState(() => message = 'Jumlah pembelian tidak valid.');
      return;
    }

    setState(() {
      isLoading = true;
      message = null;
    });

    try {
      final result = await profile_api.buyEquipment(equipment.id, quantityToBuy);
      setState(() => message = result['message']);
      if (result['success'] == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Pembelian berhasil!')));
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => message = 'Terjadi kesalahan: $e');
    } finally {
      setState(() => isLoading = false);
    }
>>>>>>> 7036f0e (backend + update frontend & database)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(title: const Text("Detail Equipment")),
      body: FutureBuilder<Equipment>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Equipment tidak ditemukan"));
          }

          final equipment = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(equipment.imageUrl, width: double.infinity, height: 250, fit: BoxFit.cover)),
                const SizedBox(height: 20),
                Text(equipment.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                  child: Text(equipment.type, style: const TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 16),
                Text(equipment.description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Stok Tersedia", style: TextStyle(color: Colors.white60, fontSize: 12)),
                        Text("${equipment.stock} unit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Harga", style: TextStyle(color: Colors.white60, fontSize: 12)),
                        Text("${equipment.price} LT", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF6C63FF)))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                if (message != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: Text(message!, style: const TextStyle(color: Colors.red, fontSize: 14)),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Jumlah",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onChanged: (value) => setState(() => quantityToBuy = int.tryParse(value) ?? 1),
                      )
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () => handleBuy(equipment),
                        child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text("Beli Sekarang"),
                      )
                    )
                  ],
                )
>>>>>>> 7036f0e (backend + update frontend & database)
              ]
            )
          );
        }
      )
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 7036f0e (backend + update frontend & database)
