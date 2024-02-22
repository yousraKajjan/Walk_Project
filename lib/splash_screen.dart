import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String nextPage = "";
  @override
  void initState() {
    initNextPage();
    super.initState();
  }

  initNextPage() async {
    // final instance = await SharedPreferences.getInstance();
    // if (instance.getStringList("data") != null) {
    // if (cacheHelper.getUser() != null) {
    //   nextPage = "/home";
    // } else {
    //   nextPage = "/login";
    // }
    if (FirebaseAuth.instance.currentUser != null) {
      nextPage = "/home";
    } else {
      nextPage = "/login";
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, nextPage);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 50,
        ),
      ),
    );
  }
}
