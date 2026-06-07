<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)
import 'package:flutter_application/data_models/equipment.dart';

class AdminEquipmentPage extends StatefulWidget {
  final Equipment? equipment;
  const AdminEquipmentPage({super.key, this.equipment});
<<<<<<< HEAD
  bool get isEdit => equipment != null; // Edit/Update option if equipment data was sent as well, otherwise Create/Add option
=======
  bool get isEdit => equipment != null;
>>>>>>> 7036f0e (backend + update frontend & database)

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
<<<<<<< HEAD

  void initState() {
    super.initState();
=======
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.equipment != null) {
      _name.text = widget.equipment!.name;
      _type.text = widget.equipment!.type;
      _description.text = widget.equipment!.description;
      _stock.text = widget.equipment!.stock.toString();
      _imageUrl.text = widget.equipment!.imageUrl;
      _price.text = widget.equipment!.price.toString();
    }
  }

  Future<void> _submitForm() async {
    if (_name.text.isEmpty || _type.text.isEmpty || _description.text.isEmpty || _imageUrl.text.isEmpty || _stock.text.isEmpty || _price.text.isEmpty) {
      setState(() => errorMessage = 'Semua field harus diisi.');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = {
        'name': _name.text,
        'type': _type.text,
        'description': _description.text,
        'stock': int.parse(_stock.text),
        'imageUrl': _imageUrl.text,
        'price': int.parse(_price.text),
      };

      late Map<String, dynamic> result;
      if (widget.isEdit) {
        result = await profile_api.updateEquipment(widget.equipment!.id, data);
      } else {
        result = await profile_api.createEquipment(data);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Operasi berhasil')));
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => errorMessage = 'Terjadi kesalahan: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _description.dispose();
    _stock.dispose();
    _imageUrl.dispose();
    _price.dispose();
    super.dispose();
>>>>>>> 7036f0e (backend + update frontend & database)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(title: Text(widget.isEdit ? "Edit Equipment" : "Tambah Equipment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: Text(errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 14)),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: "Nama Equipment", border: OutlineInputBorder()),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _type,
              decoration: const InputDecoration(labelText: "Tipe Equipment", border: OutlineInputBorder()),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _description,
              decoration: const InputDecoration(labelText: "Deskripsi", border: OutlineInputBorder()),
              maxLines: 3,
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _stock,
              decoration: const InputDecoration(labelText: "Stok", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _imageUrl,
              decoration: const InputDecoration(labelText: "URL Gambar", border: OutlineInputBorder()),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _price,
              decoration: const InputDecoration(labelText: "Harga", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _submitForm,
              child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.isEdit ? "Perbarui" : "Tambahkan"),
            )
          ]
        )
      )
    );
  }
}
>>>>>>> 7036f0e (backend + update frontend & database)
