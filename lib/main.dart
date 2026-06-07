import 'package:flutter/material.dart';
import 'package:flutter_application/login_form.dart';
<<<<<<< HEAD
=======
import 'package:flutter_application/pages/admin_page.dart';
import 'package:flutter_application/pages/checkout_page.dart';
import 'package:flutter_application/pages/order_list_page.dart';
import 'package:flutter_application/pages/market_page.dart';
import 'package:flutter_application/signup_form.dart';
>>>>>>> 7036f0e (backend + update frontend & database)

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: LogInPage(),
        ),
      ),
=======
    return MaterialApp(
      title: 'Wuthering Wares',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C1325),
        primaryColor: const Color(0xFF6C63FF),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF8E8DFF),
          backgroundColor: const Color(0xFF0C1325),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16213E),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
          bodySmall: TextStyle(fontSize: 14, color: Colors.white60),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF6C63FF))),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LogInPage(),
        '/signup': (_) => const SignUpPage(),
        '/market': (_) => const MarketPage(),
        '/admin': (_) => const AdminPage(),
        '/orders': (_) => const OrderListPage(),
        '/checkout': (_) => const CheckoutPage(),
      },
>>>>>>> 7036f0e (backend + update frontend & database)
    );
  }
}
