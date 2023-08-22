// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player/screens/bottomnavigation.dart';

class SplashScreaan extends StatefulWidget {
  const SplashScreaan({super.key});

  @override
  State<SplashScreaan> createState() => _SplashScreaanState();
}

class _SplashScreaanState extends State<SplashScreaan> {
  @override
  void initState() {
    super.initState();      
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {});

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splashscreen.png"), fit: BoxFit.cover),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 500, bottom: 35, right: 55, left: 45),
            child: Text("Lets Go>",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset(1.5, 1.5),
                          blurRadius: 5)
                    ])),
          ),
        ),
      ),
    );
  }
}
