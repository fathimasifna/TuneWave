import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/mostlyplayed/most_played_model.dart';


class MostPlayedScreen extends StatelessWidget {
  const MostPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Most Played"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder<Box<MostPlayedModel>>(
        valueListenable: Hive.box<MostPlayedModel>('most_played').listenable(),
        builder: (context, box, _) {
          final musicList = box.values.toList();

          musicList.sort((a, b) => b.playCount.compareTo(a.playCount));

          return ListView.builder(
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              final song = musicList[index];

              return ListTile(
                onTap: () {
                  //  Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SongScreen(
                  //       songModel: song,
                  //       musicList: recentlyPlayedNotifier, 
                  //     ),
                  //   ),
                  // );
                },
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/home.jpg'),
                  radius: 30,
                ),
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    song.title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 209, 207, 207),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                subtitle: Text(
                  song.subtitle ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

