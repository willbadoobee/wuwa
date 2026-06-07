import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/equipment.dart';
import 'package:flutter_application/pages/admin_equipment_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> { // loads things similar to Market Page
  late Future<List<Equipment>> _future;

  Future<List<Equipment>> _loadItems() async {
    return [
      // dummy data, replace with database soon
    ];
  }

  @override
  void initState() {
    super.initState();

    _future = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            itemCount: equipments.length,
            itemBuilder: (context, index) {
              final equipment = equipments[index];
              return Card(
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
                    ]
                  )
                )
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { // add/Create button
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdminEquipmentPage()) // why const?
        );
      }, child: const Icon(Icons.add)),
    );
  }
}