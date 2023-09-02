import 'package:flutter/material.dart';
import 'package:music_player/recentlyplayed/db_recently_played.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

Recently recently = Recently();

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  @override
  void initState() {
    super.initState();
    recently.getRecentSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recently Played"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: recentlyPlayedNotifier,
        builder: (BuildContext context, recentlyPlayedNotifier, Widget? child) {
          return ListView.builder(
            itemCount: recentSongsDatas.length,
            itemBuilder: (context, index) {
              final song = recentSongsDatas[index];

              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/home.jpg'),
                  radius: 30,
                ),
                title: Text(song.title ?? ''),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
               //     Text(song.subtitle ?? ''),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
