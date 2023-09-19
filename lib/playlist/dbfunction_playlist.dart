import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class PlaylistDb  {
  static ValueNotifier<List<String>> playlistNotifier =
      ValueNotifier([]);
  static final playlistDb = Hive.box<String>('playlistDb');

  static Future<void> addPlaylist(String? value) async {
    playlistDb.put(value,value!);
    getAllPlaylist();
  }

  static Future<void> getAllPlaylist() async {
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
//print(playlistNotifier.value);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(String? key) async {
    await playlistDb.delete(key);
    getAllPlaylist();
  }

  static Future<void> renameSong(String oldPlaylistName, String newPlaylistName) async {
    playlistDb.delete(oldPlaylistName);
    addPlaylist(newPlaylistName);
  


}
 
}
