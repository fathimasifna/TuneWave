import 'package:flutter/material.dart';
import 'package:music_player/playlist/playlist_model.dart';

import 'dbfunction_playlist.dart'; // Make sure to import your data model and PlaylistDb class

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _newPlaylistController = TextEditingController();
  final TextEditingController _renameSongController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _newPlaylistController,
              decoration: const InputDecoration(labelText: 'New Playlist Name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newPlaylistName = _newPlaylistController.text;
              if (newPlaylistName.isNotEmpty) {
                final newPlaylist = PlayListModel(
                  name: newPlaylistName,
                  subtitle: 'Subtitle',
                  title: 'Title',
                );
                PlaylistDb.addPlaylist(newPlaylist);
                _newPlaylistController.clear();
              }
            },
            child: const Text('Add Playlist'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ValueListenableBuilder<List<PlayListModel>>(
              valueListenable: PlaylistDb.playlistNotifier,
              builder: (context, playlists, _) {
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      title: Text(playlist.name ?? ''),
                      subtitle: Text(playlist.subtitle ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          PlaylistDb.deletePlaylist(index);
                        },
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Rename Song'),
                              content: TextField(
                                controller: _renameSongController,
                                decoration:
                                    const InputDecoration(labelText: 'New Title'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final newTitle =
                                        _renameSongController.text;
                                    if (newTitle.isNotEmpty) {
                                      PlaylistDb.renameSong(
                                          index, newTitle);
                                      _renameSongController.clear();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text('Rename'),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
