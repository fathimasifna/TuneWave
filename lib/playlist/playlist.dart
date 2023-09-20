import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/database/model/play_list_song_model/playlist_model.dart';
import 'package:music_player/playlist/add_songs_to_playlist.dart/db_functions_add_song_to_playlist.dart';

import '../database/model/data_model.dart';

import '../screens/song_screen.dart';

// ignore: must_be_immutable
class SongList extends StatefulWidget {
  String playlistName;
  SongList({super.key, required this.playlistName});

  @override
  State<SongList> createState() => _SongListtState();
}

class _SongListtState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Songs"),
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
        body: ValueListenableBuilder<Box<SongsModel>>(
          valueListenable: Hive.box<SongsModel>('music_box').listenable(),
          builder: (context, box, _) {
            final musicList = box.values.toList();
            if (musicList.isEmpty) {
              return const Center(child: Text("No Songs Found"));
            }

            return ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  AddSongToPlaylist addSongToPlaylistObj = AddSongToPlaylist();
                  bool boolPlaylistSong =
                      addSongToPlaylistObj.isPlaylistSong(musicList[index]);
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongScreen(
                            songModel: musicList[index],
                            musicList: musicList,
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
                        musicList[index].title ?? '',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 209, 207, 207),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      musicList[index].subtitle ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            boolPlaylistSong ? Icons.remove : Icons.add,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            PlaylistSongModel playListSongData =
                                PlaylistSongModel(
                                    song: musicList[index],
                                    playlistName: widget.playlistName);
                            boolPlaylistSong
                                ? AddSongToPlaylist.deleteSongFromPlaylist(
                                    playListSongData)
                                : AddSongToPlaylist.addSongToPlaylist(
                                    playListSongData);
                            setState(() {
                              boolPlaylistSong = !boolPlaylistSong;
                            });
                            final snackBar = SnackBar(
                              content: Text(
                                boolPlaylistSong
                                    ? 'Add Successfully'
                                    : 'Removed Successfully',
                              ),
                              backgroundColor: Colors.black,
                              duration: const Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
