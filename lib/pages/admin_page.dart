<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)
import 'package:flutter_application/data_models/equipment.dart';
import 'package:flutter_application/pages/admin_equipment_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

<<<<<<< HEAD
class _AdminPageState extends State<AdminPage> { // loads things similar to Market Page
  late Future<List<Equipment>> _future;

  Future<List<Equipment>> _loadItems() async {
    return [
      // dummy data, replace with database soon
    ];
=======
class _AdminPageState extends State<AdminPage> {
  late Future<List<Equipment>> _future;

  Future<List<Equipment>> _loadItems() async {
    return await profile_api.getEquipmentList();
  }

  void _refreshList() {
    setState(() => _future = _loadItems());
  }

  Future<void> _deleteEquipment(int id) async {
    final result = await profile_api.deleteEquipment(id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Operasi gagal')));
      _refreshList();
    }
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
    return Scaffold(
<<<<<<< HEAD
      body: FutureBuilder<List<Equipment>>(
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

          return ListView.builder(
=======
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
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
            return const Center(child: Text("Tidak ada equipment"));
          }

          final equipments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
>>>>>>> 7036f0e (backend + update frontend & database)
            itemCount: equipments.length,
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              return Card(
<<<<<<< HEAD
                child: ListTile(
                  title: Text(equipment.name),
                  subtitle: Text(equipment.type),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // check on run for resizing
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AdminEquipmentPage(
                            equipment: equipment
                          ))
                        );
                      }, icon: const Icon(Icons.edit)), // edit/Update button
                      IconButton(onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Delete equipment"),
                            content: const Text("Are you sure you wanna delete this piece of equipment?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // delete the equipment
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete")
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")
                              )
                            ]
                          )
                        );
                      }, icon: const Icon(Icons.delete)) // Delete button
=======
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(equipment.imageUrl, width: 50, height: 50, fit: BoxFit.cover)),
                  title: Text(equipment.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text("${equipment.type} • Stok: ${equipment.stock}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF6C63FF)),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEquipmentPage(equipment: equipment)))
                            .then((_) => _refreshList()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Hapus Equipment"),
                            content: const Text("Yakin ingin menghapus equipment ini?"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteEquipment(equipment.id);
                                },
                                child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                              )
                            ]
                          )
                        ),
                      )
>>>>>>> 7036f0e (backend + update frontend & database)
                    ]
                  )
                )
              );
            }
          );
        }
      ),
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(onPressed: () { // add/Create button
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdminEquipmentPage()) // why const?
        );
      }, child: const Icon(Icons.add)),
    );
  }
}
=======
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminEquipmentPage()))
            .then((_) => _refreshList()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
>>>>>>> 7036f0e (backend + update frontend & database)
