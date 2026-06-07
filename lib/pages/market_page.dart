<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)
import 'package:flutter_application/data_models/equipment.dart';
import 'package:flutter_application/pages/equipment_detail_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late Future<List<Equipment>> _future;
<<<<<<< HEAD
  // Product model:
  // final int id;
  // final String name;
  // final String type;
  // final String description;
  // final int stock;
  // final String imageUrl;
  // final int price;

  Future<List<Equipment>> _loadItems() async {
    // async
    return [
      // dummy data
      Equipment(
        id: 1,
        name: "Stringmaster",
        type: "Rectifier",
        description: "As the puppet palm unfurls, deadly strings are unleashed with a menacing hum.",
        stock: 5,
        imageUrl: "https://static.wikia.nocookie.net/wutheringwaves/images/1/16/Weapon_Stringmaster.png/revision/latest?cb=20240526010204",
        price: 80
      ),
      Equipment(
        id: 2,
        name: "Cadenza",
        type: "Pistol",
        description: "These pistols unleash bullets with the force of thunder, tearing through the heavens like a symphony of destruction.",
        stock: 10,
        imageUrl: "https://static.wikia.nocookie.net/wutheringwaves/images/1/1c/Weapon_Cadenza.png/revision/latest?cb=20240526012627",
        price: 50
      )
    ];
=======

  Future<List<Equipment>> _loadItems() async {
    return await profile_api.getEquipmentList();
>>>>>>> 7036f0e (backend + update frontend & database)
  }

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD

=======
>>>>>>> 7036f0e (backend + update frontend & database)
    _future = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return FutureBuilder<List<Equipment>>(
      future: _future,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}")
          );
        }

        if(!snapshot.hasData) {
          return const Center(
            child: Text("No data for equipment found")
          );
        }
        
        final equipments = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: equipments.length,
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              // something i forgot
              return Card(
                child: ListTile(
                  leading: Image.network(equipment.imageUrl),
                  title: Text(equipment.name),
                  subtitle: Text(equipment.type),
                  trailing: Text("${equipment.price} LT"),
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (_) => EquipmentDetailPage(equipmentId: equipment.id)
                      )
                    );
                  }
                )
              );
            }
          )
        );
      }
    );
  }
}
=======
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/orders'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )
        ],
      ),
      body: FutureBuilder<List<Equipment>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada equipment tersedia"));
          }

          final equipments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: equipments.length,
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(equipment.imageUrl, width: 50, height: 50, fit: BoxFit.cover)),
                  title: Text(equipment.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(equipment.type),
                  trailing: Text("${equipment.price} LT", style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF6C63FF))),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EquipmentDetailPage(equipmentId: equipment.id))),
                )
              );
            }
          );
        }
      )
    );
  }
}
>>>>>>> 7036f0e (backend + update frontend & database)
