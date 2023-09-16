import 'package:flutter/material.dart';
import 'package:music_player/playlist/add_songs_to_playlist.dart/db_functions_add_song_to_playlist.dart';
import 'package:music_player/playlist/dbfunction_playlist.dart';
import 'package:music_player/playlist/playlist.dart';

import 'Playlist-list.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _newPlaylistController = TextEditingController();
  final TextEditingController _renamePlaylistController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play List"),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _newPlaylistController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'New Playlist Name',
                labelStyle: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newPlaylistName = _newPlaylistController.text;
              if (newPlaylistName.isNotEmpty) {
                final newPlaylist = (name: newPlaylistName,);
                PlaylistDb.addPlaylist(newPlaylist.name);
                _newPlaylistController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shadowColor: Colors.black,
            ),
            child: const Text('Add Playlist'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: PlaylistDb.playlistNotifier,
              builder: (context, List<String> playlists, _) {
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AddSongToPlaylist.getSongsFromDb(playlists[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListToList(),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          playlists[index],
                          style: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          const Color.fromARGB(255, 40, 32, 51),
                                      title: const Text(
                                        'Delete Playlist',
                                        style: TextStyle(
                                          color: Colors.white54,
                                        ),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete this playlist?',
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
                                            PlaylistDb.deletePlaylist(
                                                playlists[index]);
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
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                _renamePlaylistController.text =
                                    playlists[index];

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          const Color.fromARGB(255, 40, 32, 51),
                                      content: Container(
                                        color: const Color.fromARGB(
                                            255, 40, 32, 51),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Rename Playlist',
                                              style: TextStyle(
                                                  color: Colors.white54),
                                            ),
                                            TextField(
                                              controller:
                                                  _renamePlaylistController,
                                              decoration: const InputDecoration(
                                                labelText: 'New Playlist Name',
                                                labelStyle: TextStyle(
                                                    color: Colors.white54),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white54),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    final newPlaylistName =
                                                        _renamePlaylistController
                                                            .text;
                                                    if (newPlaylistName
                                                        .isNotEmpty) {
                                                      PlaylistDb.renameSong(
                                                        playlists[index],
                                                        newPlaylistName,
                                                      );
                                                      _renamePlaylistController
                                                          .clear();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Rename',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                AddSongToPlaylist.getSongsFromDb(playlists[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  SongList(playlistName:playlists[index]),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
