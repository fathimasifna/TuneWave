import 'package:flutter/material.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/mostlyplayed/most_played_dbfunction.dart';
import 'package:music_player/screens/song_screen.dart';

import 'most_played_model.dart';

class MostPlayedScreen extends StatelessWidget {
  const MostPlayedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Most Played"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 40, 32, 51),
      body: ValueListenableBuilder<List<SongsModel>>(
        valueListenable: mostlyPlayedNotifier,
        builder: (context, musicList, _) {
          if (musicList.length > 10) {
            musicList = musicList.sublist(0, 10);
          }

          return ListView.separated( 
            itemCount: musicList.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                thickness: 0.08,
              );
            },
            itemBuilder: (context, index) {
              final song = musicList[index];

              return ListTile(
                onTap: () {
                  _handleSongTap(context, song);
                },
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/home.jpg'),
                  radius: 30,
                ),
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    song.title ?? '',
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
                subtitle: Text(
                  song.subtitle ?? '',
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _handleSongTap(BuildContext context, SongsModel song) {
    addMostlyPlayed(MostPlayedModel(
      id: song.id,
      title: song.title!,
      subtitle: song.subtitle,
      uri: song.audioUri!,
    ));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongScreen(
          songModel: song,
          musicList: mostlyPlayedNotifier.value,
        ),
      ),
    );
  }
}
