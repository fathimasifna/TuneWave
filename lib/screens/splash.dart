import 'package:flutter/material.dart';
import 'package:music_player/screens/bottomnavigation.dart';
import '../favorite/favorite_dbfunction.dart';
import '../mostlyplayed/most_played_dbfunction.dart';
import '../playlist/dbfunction_playlist.dart';

class SplashScreaan extends StatefulWidget {
  const SplashScreaan({super.key});

  @override
  State<SplashScreaan> createState() => _SplashScreaanState();
}

class _SplashScreaanState extends State<SplashScreaan> {
  @override
  void initState() {
    super.initState();
    Favorite favoriteObj = Favorite();
    favoriteObj.getFavorSongs();
    _navigatetohome();
    getAllPlayed();

    PlaylistDb.getAllPlaylist();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 1), () {});

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splashscreen.png"),
              fit: BoxFit.cover),
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
