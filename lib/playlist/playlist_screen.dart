import 'package:flutter/material.dart';
import 'package:music_player/playlist/playlist_model.dart';

import 'dbfunction_playlist.dart';

class PlayListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlists"),
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
      body: PlaylistContent(),
    );
  }
}

class PlaylistContent extends StatefulWidget {
  @override
  _PlaylistContentState createState() => _PlaylistContentState();
}

class _PlaylistContentState extends State<PlaylistContent> {
  @override
  void initState() {
    super.initState();
    PlaylistDb.getAllPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 40, 32, 51),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showCreatePlaylistDialog(context);
              },
              child: const Text('Create Playlist'),
            ),
          ),
          ValueListenableBuilder<List<SongModel>>(
            valueListenable: PlaylistDb.playlistNotifier,
            builder: (context, playlist, _) {
              return Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    return _buildPlaylistItem(context, playlist[index], index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistItem(BuildContext context, SongModel song, int index) {
    return ListTile(
      title: Text(song.name!),
      subtitle: Text(song.subtitle!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _renamePlaylist(context, index);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              _deletePlaylist(index);
            },
          ),
        ],
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) async {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _subtitleController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Playlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: _subtitleController, decoration: InputDecoration(labelText: 'Subtitle')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = _nameController.text;
                final subtitle = _subtitleController.text;
                if (name.isNotEmpty && subtitle.isNotEmpty) {
                  final newPlaylist = SongModel(
                    name: name,
                    subtitle: subtitle,
                    title: name,
                  );
                  await PlaylistDb.addPlaylist(newPlaylist);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playlist created successfully')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid name and subtitle')));
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _renamePlaylist(BuildContext context, int index) async {
    final TextEditingController controller =
        TextEditingController(text: PlaylistDb.playlistNotifier.value[index].name);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Playlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: controller, decoration: const InputDecoration(labelText: 'New Name'),
              
              
              
              ),
              
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newName = controller.text;
                if (newName.isNotEmpty) {
                  await PlaylistDb.renameSong(index, newName);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playlist renamed successfully')));
                }
              },
              child: Text('Rename'),
            ),
          ],
        );
      },
    );
  }

  void _deletePlaylist(int index) async {
    await PlaylistDb.deletePlaylist(index);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playlist deleted successfully')));
  }
}
