import 'package:flutter/material.dart';
import 'package:music_player/favorite/favorite.dart';

import '../playlist/playlist_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "My Library",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 40, 32, 51),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(
                "FAVORITE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>   FavoriteScreen(favoriteSongs: const [], updateFavoriteStatus: (int songId, bool isFavorite) {  },),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(favoriteSongs: const [], updateFavoriteStatus: (int songId, bool isFavorite) {  },),  
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "PLAY LIST",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PlayListScreen(),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   PlayListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
 