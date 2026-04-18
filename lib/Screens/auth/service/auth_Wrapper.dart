import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/Screens/Welcome.dart';
import '../../Home.dart';
import '../Signup.dart';
import '../login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Logged in
        if (snapshot.hasData) {
          return const Home();

        }

        // Not logged in
        return const Login();
      },
    );
  }
}
