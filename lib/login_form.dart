import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  String username = "";
  String password = "";

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
              )
            ]
          )
        )
      )
    );
  }
}