import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:quantam/News/Presentation/Screens/SearchNews_Screen.dart';
import 'package:quantam/signin.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignIN()),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SearchNewsScreen()),
              (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/quantum.png")),
    );
  }
}
