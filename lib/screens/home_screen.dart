import 'package:flutter/material.dart';
import 'package:music_player/mostlyplayed/most_played.dart';
import 'package:music_player/recentlyplayed/recently_played.dart';
import 'package:music_player/screens/all_music.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    try {
      bool status = await _audioQuery.permissionsStatus();
      if (!status) {
        await _audioQuery.permissionsRequest();
        await Permission.storage.request();
      }
    } catch (e) {
      print('Error requesting permission $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 32, 51),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          "TuneWave",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpansionTile("Recently Played", "assets/images/home.jpg",
                const RecentlyPlayedScreen()),
            _buildExpansionTile("Mostly Played", "assets/images/home.jpg",
                const MostPlayedScreen()),
            _buildSectionHeader("Your Songs"),
            const SizedBox(
              height: 500,
              width: double.maxFinite,
              child: Center(
                child: AllMusic(),
              ),
            ),
          ],
        ),
      ),
    );
  }

     _buildExpansionTile(String title, String imageAsset, Widget page) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black87,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  imageAsset,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13, left: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
