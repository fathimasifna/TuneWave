import 'package:flutter/material.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/favorite/favorite_dbfunction.dart';
import 'package:music_player/screens/song_screen.dart';

class FavoriteScreen extends StatefulWidget {
  final Function(int songId, bool isFavorite) updateFavoriteStatus;

  const FavoriteScreen({
    required this.updateFavoriteStatus,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Set<SongsModel> favoriteSongsSet = {};

  @override
  void initState() {
    super.initState();
    favoriteSongsSet = Set.from(favoriteSongsDatas);
  }

  void removeFromFavorites(SongsModel song) async {
    Favorite favoriteObj = Favorite();
    setState(() {
      favoriteSongsSet.remove(song);
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
            favoriteSongsSet.add(song);
          });
          widget.updateFavoriteStatus(song.id!, true);
          favoriteObj.addToFavorite(song);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    widget.updateFavoriteStatus(song.id!, false);
    favoriteObj.deleteFavSongsFromDatabase(song);
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
        child: ListView.separated(
          itemCount: favoriteSongsSet.length,
          itemBuilder: (context, index) {
            final song = favoriteSongsSet.elementAt(index);
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongScreen(
                      songModel: song,
                      musicList: favoriteSongsSet.toList(),
                    ),
                  ),
                );
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/home.jpg'),
                radius: 30,
              ),
              title: Text(
                song.title ?? '',
                style: const TextStyle(color: Colors.white54),
              ),
              subtitle: Text(
                song.subtitle ?? ' ',
                style: const TextStyle(color: Colors.white54),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeFromFavorites(song);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.white,
              thickness: 0.8,
            );
          },
        ),
      ),
    );
  }
}
