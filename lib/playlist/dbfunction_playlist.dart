import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:music_player/playlist/playlist_model.dart';

class PlaylistDb extends ChangeNotifier {
  static ValueNotifier<List<PlayListModel>> playlistNotifier = ValueNotifier([]);
  static final playlistDb = Hive.box<PlayListModel>('playlistDb');

  static Future<void> addPlaylist(PlayListModel value) async {
    final playlistDb = await Hive.openBox<PlayListModel>('playlistDb');
    playlistDb.add(value);
    playlistNotifier.value.add(value);
    playlistNotifier.notifyListeners();
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = await Hive.openBox<PlayListModel>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = await Hive.openBox<PlayListModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> renameSong(int index, String newTitle) async {
    final playlistDb = await Hive.openBox<PlayListModel>('playlistDb');
    final song = playlistDb.getAt(index);
    if (song != null) {
      final updatedSong = song.copyWith(title: newTitle);
      await playlistDb.putAt(index, updatedSong);
      getAllPlaylist();
    }
  }

  static void renamePlaylist(int index, String newPlaylistName) {}
}
