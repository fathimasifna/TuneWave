import 'package:flutter/material.dart';
import 'package:music_player/playlist/add_songs_to_playlist.dart/db_functions_add_song_to_playlist.dart';

import '../database/model/play_list_song_model/playlist_model.dart';
import '../screens/song_screen.dart';

class ListToList extends StatefulWidget {
  const ListToList({Key? key});

  @override
  State<ListToList> createState() => _ListToListState();
}

class _ListToListState extends State<ListToList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("name"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 40, 32, 51),
      body: ValueListenableBuilder<List<PlaylistSongModel>>(
        valueListenable: AddSongToPlaylist.playlistNotifier,
        builder: (context, musicList, _) {
          return ListView.separated(
            itemCount: musicList.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                thickness: 0.08,
              );
            },
            itemBuilder: (context, index) {
              final song = musicList[index].song;

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongScreen(
                        songModel: song,
                        musicList: const [],
                      ),
                    ),
                  );
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
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                subtitle: Text(
                  song.subtitle ?? '',
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white54, 
                  ),
                  onPressed: () {
                  
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color.fromARGB(255, 40, 32, 51),
                          title: const Text(
                            'Delete Song',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to delete this song?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                              
                                setState(() {
                                  musicList.removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
