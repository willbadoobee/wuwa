<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username = "";
  String email = "";
  String password = "";
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  setState(() {
                    username = value.toString();
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  setState(() {
                    email = value.toString();
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder()
                ),
                onChanged:(value) {
                  setState(() {
                    password = value.toString();
                  });
                },
              ),
              // textfield below might be unnecessary
              TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder()
                ),
                onChanged:(value) {
                  setState(() {
                    password = value.toString();
                  });
                },
              ),
              OutlinedButton(
                onPressed:() {
                  
                } ,
                child: Text("Log In")
              )
            ]
          )
=======
  String confirmPassword = "";
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleSignUp() async {
    setState(() => errorMessage = null);

    final result = await profile_api.onRegister(username, email, password, confirmPassword);
    
    setState(() => isLoading = false);
    if (result['success'] == true) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/market');
    } else {
      setState(() => errorMessage = result['message'] ?? 'Registrasi gagal.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar'), leading: BackButton(onPressed: () => Navigator.pop(context))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Buat Akun Baru', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Bergabunglah dengan Wuthering Wares', style: TextStyle(fontSize: 16, color: Colors.white60)),
            const SizedBox(height: 30),
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: Text(errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 14)),
              ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: "Username", border: OutlineInputBorder()),
              onChanged: (value) => setState(() => username = value),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
              onChanged: (value) => setState(() => email = value),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
              obscureText: true,
              onChanged: (value) => setState(() => password = value),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Konfirmasi Password", border: OutlineInputBorder()),
              obscureText: true,
              onChanged: (value) => setState(() => confirmPassword = value),
              enabled: !isLoading,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : handleSignUp,
              child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text("Daftar"),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sudah punya akun? "),
                GestureDetector(
                  onTap: isLoading ? null : () => Navigator.pop(context),
                  child: const Text("Masuk", style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600)),
                )
              ]
            )
          ]
>>>>>>> 7036f0e (backend + update frontend & database)
        )
      )
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 7036f0e (backend + update frontend & database)
