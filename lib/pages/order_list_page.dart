<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
import 'package:flutter_application/data_models/order.dart';
>>>>>>> 7036f0e (backend + update frontend & database)

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
=======
  late Future<List<Order>> _future;

  Future<List<Order>> _loadOrders() async {
    return await profile_api.fetchOrders();
  }

  @override
  void initState() {
    super.initState();
    _future = _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Saya')),
      body: FutureBuilder<List<Order>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada pembelian"));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.equipmentName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text("Jumlah: ${order.quantity} unit", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                              ],
                            )
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                            child: Text("${order.total} LT", style: const TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600)),
                          )
                        ]
                      ),
                      const SizedBox(height: 12),
                      Text("Tanggal: ${order.purchasedAt}", style: const TextStyle(color: Colors.white60, fontSize: 12))
                    ]
                  )
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
