import 'package:flutter/material.dart';
import 'package:music_player/recentlyplayed/db_recently_played.dart';

import '../database/model/data_model.dart';
import '../screens/song_screen.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({Key? key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

Recently recently = Recently();

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  late SongsModel songModel;
  late List<SongsModel> musicList;

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
      backgroundColor: const Color.fromARGB(255, 40, 32, 51),
      body: ValueListenableBuilder(
        valueListenable: recentlyPlayedNotifier,
        builder: (BuildContext context, recentlyPlayedNotifier, Widget? child) {
          final List<SongsModel> latestSongs =
              recentlyPlayedNotifier.reversed.take(10).toList();

          return ListView.separated(
            itemCount: latestSongs.length,
            itemBuilder: (context, index) {
              final song = latestSongs[index];

              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/home.jpg'),
                  radius: 30,
                ),
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      song.title ?? '',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                subtitle: Text(
                  song.subtitle ?? '',
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongScreen(
                        songModel: song,
                        musicList: latestSongs,
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                thickness: 0.08,
              );
            },
          );
        },
      ),
    );
  }
}
