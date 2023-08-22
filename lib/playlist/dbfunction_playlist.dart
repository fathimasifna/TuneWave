import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:music_player/playlist/playlist_model.dart';

class PlaylistDb extends ChangeNotifier {
  static ValueNotifier<List<SongModel>> playlistNotifier = ValueNotifier([]);
  static final playlistDb = Hive.box<SongModel>('playlistDb');

  static Future<void> addPlaylist(SongModel value) async {
    final playlistDb = await Hive.openBox<SongModel>('playlistDb');
    playlistDb.add(value);
    playlistNotifier.value.add(value);
    playlistNotifier.notifyListeners();
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = await Hive.openBox<SongModel>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = await Hive.openBox<SongModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> renameSong(int index, String newTitle) async {
    final playlistDb = await Hive.openBox<SongModel>('playlistDb');
    final song = playlistDb.getAt(index);
    if (song != null) {
      final updatedSong = song.copyWith(title: newTitle);
      await playlistDb.putAt(index, updatedSong);
      getAllPlaylist();
    }
  }
}
