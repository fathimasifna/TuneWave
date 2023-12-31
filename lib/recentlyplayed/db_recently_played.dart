// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/recentlyplayed/recent_model.dart';
import '../database/fuctions/all_music_db_functions.dart';

List<RecentListModel> recentSongsDatas = [];

ValueNotifier<List<SongsModel>> recentlyPlayedNotifier = ValueNotifier([]);

class Recently {
  final recentMusicDb = Hive.box<RecentListModel>('recent_box');

  addToRecents(RecentListModel song) async {
    try {
      recentMusicDb.put(song.id, song);
    } catch (e) {
      print(e);
    }
    getRecentSongs();
  }

  getRecentSongs() {
    recentSongsDatas = recentMusicDb.values.toList();
    recentlyPlayedNotifier.value.clear();
    recentSongsDatas.sort((a, b) => a.time!.compareTo(b.time!));
    for (var song in recentSongsDatas) {
      for (var element in allSongsData) {
        if (song.id == element.id) {
          recentlyPlayedNotifier.value.add(element);
        }
      }
    }
  }
}
