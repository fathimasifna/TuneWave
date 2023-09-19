// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../database/model/data_model.dart';

List<SongsModel> favoriteSongsDatas = [];

bool isInitialized = false;

ValueNotifier<List<SongsModel>> favoriteSongs = ValueNotifier([]);

clear() async {
  favoriteSongs.value.clear();
}

//--Favorite Database Functions--
class Favorite {
  final favoriteMusicDb = Hive.box<SongsModel>('favorite_songs');

  bool isFav(SongsModel song) {
    for (SongsModel value in favoriteSongsDatas) {
      if (value.id == song.id) {
        return true;
      }
    }
    return false;
  }

  addToFavorite(SongsModel song) async {
    try {
      favoriteMusicDb.put(song.id, song);
    } catch (e) {
      print(e);
    }
    await getFavorSongs();
  }

  getFavorSongs() {
    favoriteSongsDatas.clear();
    favoriteSongsDatas = favoriteMusicDb.values.toList();
  }

  deleteFavSongsFromDatabase(SongsModel song) {
    favoriteMusicDb.delete(song.id);
    getFavorSongs();
  }
}
