import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_player/recentlyplayed/recent_model.dart';

List<RecentListModel> recentSongsDatas = [];

ValueNotifier<List<RecentListModel>> recentlyPlayedNotifier = ValueNotifier([]);

class Recently {
  final recentMusicDb = Hive.box<RecentListModel>('recent_box');

  addToRecents(RecentListModel song) async {
    try {
      recentMusicDb.add(song);
    } catch (e) {
      print(e);
    }
    getRecentSongs();
  }

  getRecentSongs() {
    recentSongsDatas.clear();
    recentSongsDatas = recentMusicDb.values.toList();
    recentlyPlayedNotifier.value = List.from(recentSongsDatas);
  }
}
