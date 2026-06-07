<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
﻿import 'package:flutter/material.dart';
import 'package:flutter_application/apis/profile.dart' as profile_api;
>>>>>>> 7036f0e (backend + update frontend & database)

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  String username = "";
  String password = "";
<<<<<<< HEAD
=======
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleLogin() async {
    if (username.trim().isEmpty) {
      setState(() => errorMessage = 'Username tidak boleh kosong.');
      return;
    }
    if (password.length < 6) {
      setState(() => errorMessage = 'Password minimal 6 karakter.');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await profile_api.onLogin(username, password);
      if (result['success'] == true) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, 
          profile_api.currentRole == 'admin' ? '/admin' : '/market');
      } else {
        setState(() => errorMessage = result['message'] ?? 'Login gagal.');
      }
    } catch (e) {
      setState(() => errorMessage = 'Terjadi kesalahan: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }
>>>>>>> 7036f0e (backend + update frontend & database)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
<<<<<<< HEAD
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
                  labelText: "Password",
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
=======
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Wuthering Wares', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Marketplace Resonator', style: TextStyle(fontSize: 16, color: Colors.white60)),
              const SizedBox(height: 40),
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
                decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : handleLogin,
                child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text("Log In"),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak punya akun? "),
                  GestureDetector(
                    onTap: isLoading ? null : () => Navigator.pushNamed(context, '/signup'),
                    child: const Text("Daftar", style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600)),
                  )
                ]
>>>>>>> 7036f0e (backend + update frontend & database)
              )
            ]
          )
        )
      )
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 7036f0e (backend + update frontend & database)
