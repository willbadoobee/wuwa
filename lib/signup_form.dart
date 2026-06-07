import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username = "";
  String email = "";
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
        )
      )
    );
  }
}