import 'package:flutter/material.dart';
import 'package:music_player/playlist/playlist_model.dart';
import 'package:music_player/playlist/dbfunction_playlist.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _newPlaylistController = TextEditingController();
  final TextEditingController _renamePlaylistController = TextEditingController();

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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              PlaylistDb.deletePlaylist(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _renamePlaylistController.text = playlist.name ?? '';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Rename Playlist'),
                                    content: TextField(
                                      controller: _renamePlaylistController,
                                      decoration: const InputDecoration(
                                        labelText: 'New Playlist Name',
                                      ),
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
                                          final newPlaylistName =
                                              _renamePlaylistController.text;
                                          if (newPlaylistName.isNotEmpty) {
                                            PlaylistDb.renamePlaylist(
                                                index, newPlaylistName);
                                            _renamePlaylistController.clear();
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
                          ),
                        ],
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
