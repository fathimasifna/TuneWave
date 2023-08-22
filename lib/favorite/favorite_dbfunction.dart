import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../database/model/data_model.dart';

class FavoriteDb {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('favorite_songs_box');
  static ValueNotifier<List<SongsModel>> favoriteSongs = ValueNotifier([]);

  static initialize(List<SongsModel> songslist) {
    for (SongsModel song in songslist) {
      if (isFavor(song)) {
        favoriteSongs.value.add(song);
      }
    }
    isInitialized = true;
  }

  static bool isFavor(SongsModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    } else {
      return false;
    }
  }

  static add(SongsModel song) async {
    musicDb.add(song.id!);
    favoriteSongs.value.add(song);
    FavoriteDb.favoriteSongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDb.delete(deletekey);
    favoriteSongs.value.removeWhere((song) => song.id == id);
    FavoriteDb.favoriteSongs.notifyListeners();
  }

  static clear() async {
    FavoriteDb.favoriteSongs.value.clear();
  }
  void _addToFavoriteBox(SongsModel song) {
    final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
    favoriteBox.put(song.id, song);
  }

  void _removeFromFavoriteBox(SongsModel song) {
    final favoriteBox = Hive.box<SongsModel>('favorite_songs_box');
    favoriteBox.delete(song.id);
  }
}
