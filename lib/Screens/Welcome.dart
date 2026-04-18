import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset("assets/icon.svg"),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
