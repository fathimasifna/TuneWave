import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/favorite/favorite_dbfunction.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/recentlyplayed/recent_model.dart';
import 'package:music_player/recentlyplayed/recently_played.dart';
import 'package:music_player/screens/song_screen.dart';

import '../favorite/favorite.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({Key? key}) : super(key: key);

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPlaylistController = TextEditingController();
  List<SongsModel> favoriteSongs = [];

  Future<void> playSong(String uri) async {
    final audioSource = AudioSource.uri(Uri.parse(uri));
    try {
      await audioPlayer.setAudioSource(audioSource);
      audioPlayer.play();
    } catch (e) {
      print('Error on playing Songs: $e');
    }
  }

  Future<void> toggleFavorite(SongsModel song) async {
    setState(() {
      song.isFavorite = !song.isFavorite;
    });
    Favorite favorite = Favorite();
    // final musicBox = Hive.box<SongsModel>('music_box');
    // await musicBox.put(song.id, song);

    if (song.isFavorite) {
      favorite.addToFavorite(song);
      favoriteSongs.add(song);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoriteScreen(
            updateFavoriteStatus: updateFavoriteStatus,
          ),
        ),
      );
    } else {
      await favorite.deleteFavSongsFromDatabase(song);
      // _removeFromFavoriteBox(song);
      favoriteSongs.removeWhere((favSong) => favSong.id == song.id);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoriteScreen(
            updateFavoriteStatus: updateFavoriteStatus,
          ),
        ),
      );
    }
  }

  void updateFavoriteStatus(int songId, bool isFavorite) {
    // final musicBox = Hive.box<SongsModel>('music_box');
    // final song = musicBox.get(songId);
    // if (song != null) {
    //   song.isFavorite = isFavorite;
    //   addToFavorite(song);
    // }
  }

  // void _addToFavoriteBox(SongsModel song) {
  //   final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
  //   favoriteBox.put(song.id, song);
  // }

  // void _removeFromFavoriteBox(SongsModel song) {
  //   final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
  //   favoriteBox.delete(song.id);
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<SongsModel>>(
      valueListenable: Hive.box<SongsModel>('music_box').listenable(),
      builder: (context, box, _) {
        final musicList = box.values.toList();
        if (musicList.isEmpty) {
          return const Center(child: Text("No Songs Found"));
        }

        favoriteSongs = musicList.where((song) => song.isFavorite).toList();

        return ListView.builder(
            itemCount: musicList.length,
            itemBuilder: (
              context,
              index,
            ) {
              Favorite favoriteObj = Favorite();
              bool boolFav = favoriteObj.isFav(musicList[index]);
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

                  final song = RecentListModel(
                    id: musicList[index].id,
                    title: musicList[index].title,
                    subtitle: musicList[index].subtitle,
                  );
                  recently.addToRecents(song);
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
                        boolFav ? Icons.favorite : Icons.favorite_border,
                        color: boolFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () async {
                        await toggleFavorite(musicList[index]);
                        setState(() {
                          boolFav = !boolFav;
                        });
                        final snackBar = SnackBar(
                          content: Text(
                            musicList[index].isFavorite
                                ? 'Added Successfully'
                                : 'Deleted Successfully',
                          ),
                          backgroundColor: Colors.black,
                          duration: const Duration(seconds: 1),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.playlist_play,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        newPlayListDialog(context);
                      },
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  void newPlayListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 158, 158, 158),
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: TextFormField(
                controller: _newPlaylistController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Enter playlist name',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid playlist name';
                  }
                  return null;
                },
              ),
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
