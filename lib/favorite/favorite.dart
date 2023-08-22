import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/screens/song_screen.dart';

class FavoriteScreen extends StatefulWidget {
  final List<SongsModel> favoriteSongs;
  final Function(int songId, bool isFavorite) updateFavoriteStatus;

  const FavoriteScreen({
    required this.favoriteSongs,
    required this.updateFavoriteStatus,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void removeFromFavorites(SongsModel song) async {
    setState(() {
      widget.favoriteSongs.remove(song);
    });

    final snackBar = SnackBar(
      content: const Text('Song removed from favorites'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.white,
        onPressed: () {
          setState(() {
            widget.favoriteSongs.add(song);
          });
          widget.updateFavoriteStatus(song.id!, true);
          _addToFavoriteBox(song); // Add song back to favorites
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    widget.updateFavoriteStatus(song.id!, false);
    _removeFromFavoriteBox(song); 
  }

  void _addToFavoriteBox(SongsModel song) {
    final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
    favoriteBox.put(song.id, song);
  }

  void _removeFromFavoriteBox(SongsModel song) {
    final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
    favoriteBox.delete(song.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
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
      body: Container(
        color: const Color.fromARGB(255, 40, 32, 51),
        child: ListView.builder(
          itemCount: widget.favoriteSongs.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongScreen(
                    songModel: widget.favoriteSongs[index],
                    musicList: widget.favoriteSongs,
                  ),
                ),
              );
            },
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/home.jpg'),
              radius: 30,
            ),
            title: Text(
              widget.favoriteSongs[index].title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              widget.favoriteSongs[index].subtitle ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                removeFromFavorites(widget.favoriteSongs[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
