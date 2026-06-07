<<<<<<< HEAD
import "dart:convert";
import "package:http/http.dart";

// register
Future<(bool, String)> onRegister(String username, String email, String password) async {
  return ;
}

// login maybe
Future<(bool, String)> onLogin(String username, String password) async {
  return ;
}
=======
﻿import 'dart:convert';
import 'package:flutter_application/data_models/equipment.dart';
import 'package:flutter_application/data_models/order.dart';
import 'package:http/http.dart' as http;

const String backendUrl = 'http://192.168.0.102:3000/api';
String? bearerToken;
String? currentRole;

Map<String, String> _headers({bool auth = false}) {
  final headers = {'Content-Type': 'application/json'};
  if (auth && bearerToken != null) {
    headers['Authorization'] = 'Bearer $bearerToken';
  }
  return headers;
}

Future<Map<String, dynamic>> onRegister(String username, String email, String password, String confirmPassword) async {
  if (username.trim().isEmpty) {
    return {'success': false, 'message': 'Username wajib diisi.'};
  }
  if (email.trim().isEmpty) {
    return {'success': false, 'message': 'E-mail wajib diisi.'};
  }
  final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
  if (!emailPattern.hasMatch(email)) {
    return {'success': false, 'message': 'Format e-mail tidak valid.'};
  }
  if (password.length < 6) {
    return {'success': false, 'message': 'Password minimal 6 karakter.'};
  }
  if (password != confirmPassword) {
    return {'success': false, 'message': 'Password dan konfirmasi tidak cocok.'};
  }

  final response = await http.post(
    Uri.parse('$backendUrl/auth/register'),
    headers: _headers(),
    body: jsonEncode({'username': username, 'email': email, 'password': password}),
  );

  final body = jsonDecode(response.body);
  if (body['success'] == true) {
    bearerToken = body['token'] as String?;
    currentRole = body['user']?['role'] as String?;
  }
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Registrasi gagal.'};
}

Future<Map<String, dynamic>> onLogin(String username, String password) async {
  if (username.trim().isEmpty) {
    return {'success': false, 'message': 'Username wajib diisi.'};
  }
  if (password.length < 6) {
    return {'success': false, 'message': 'Password minimal 6 karakter.'};
  }

  final response = await http.post(
    Uri.parse('$backendUrl/auth/login'),
    headers: _headers(),
    body: jsonEncode({'username': username, 'password': password}),
  );

  final body = jsonDecode(response.body);
  if (body['success'] == true) {
    bearerToken = body['token'] as String?;
    currentRole = body['user']?['role'] as String?;
  }
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Login gagal.'};
}

Future<Map<String, dynamic>> onGoogleSignIn(String idToken) async {
  if (idToken.isEmpty) {
    return {'success': false, 'message': 'Token Google tidak boleh kosong.'};
  }
  final response = await http.post(
    Uri.parse('$backendUrl/auth/google'),
    headers: _headers(),
    body: jsonEncode({'idToken': idToken}),
  );
  final body = jsonDecode(response.body);
  if (body['success'] == true) {
    bearerToken = body['token'] as String?;
    currentRole = body['user']?['role'] as String?;
  }
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Login Google gagal.'};
}

Future<List<Equipment>> getEquipmentList() async {
  final response = await http.get(Uri.parse('$backendUrl/equipment'), headers: _headers());
  final body = jsonDecode(response.body);
  if (body['success'] == true && body['data'] is List) {
    return (body['data'] as List).map((item) => Equipment.fromJson(item as Map<String, dynamic>)).toList();
  }
  throw Exception(body['message'] ?? 'Gagal memuat equipment.');
}

Future<Equipment> getEquipmentById(int id) async {
  final response = await http.get(Uri.parse('$backendUrl/equipment/$id'), headers: _headers());
  final body = jsonDecode(response.body);
  if (body['success'] == true && body['data'] is Map) {
    return Equipment.fromJson(body['data'] as Map<String, dynamic>);
  }
  throw Exception(body['message'] ?? 'Gagal memuat detail equipment.');
}

Future<Map<String, dynamic>> createEquipment(Map<String, dynamic> data) async {
  final response = await http.post(Uri.parse('$backendUrl/equipment'), headers: _headers(auth: true), body: jsonEncode(data));
  final body = jsonDecode(response.body);
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Gagal membuat equipment.'};
}

Future<Map<String, dynamic>> updateEquipment(int id, Map<String, dynamic> data) async {
  final response = await http.put(Uri.parse('$backendUrl/equipment/$id'), headers: _headers(auth: true), body: jsonEncode(data));
  final body = jsonDecode(response.body);
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Gagal memperbarui equipment.'};
}

Future<Map<String, dynamic>> deleteEquipment(int id) async {
  final response = await http.delete(Uri.parse('$backendUrl/equipment/$id'), headers: _headers(auth: true));
  final body = jsonDecode(response.body);
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Gagal menghapus equipment.'};
}

Future<Map<String, dynamic>> buyEquipment(int equipmentId, int quantity) async {
  final response = await http.post(
    Uri.parse('$backendUrl/orders'),
    headers: _headers(auth: true),
    body: jsonEncode({'equipmentId': equipmentId, 'quantity': quantity}),
  );
  final body = jsonDecode(response.body);
  return {'success': body['success'] == true, 'message': body['message'] ?? 'Pembelian gagal.'};
}

Future<List<Order>> fetchOrders() async {
  final response = await http.get(Uri.parse('$backendUrl/orders'), headers: _headers(auth: true));
  final body = jsonDecode(response.body);
  if (body['success'] == true && body['data'] is List) {
    return (body['data'] as List).map((item) => Order.fromJson(item as Map<String, dynamic>)).toList();
  }
  throw Exception(body['message'] ?? 'Gagal memuat pesanan.');
}
>>>>>>> 7036f0e (backend + update frontend & database)
