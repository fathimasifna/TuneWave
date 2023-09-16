import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:music_player/database/model/play_list_song_model/playlist_model.dart';
import '../../database/model/data_model.dart';

class AddSongToPlaylist {
  static ValueNotifier<List<PlaylistSongModel>> playlistNotifier = ValueNotifier([]);
  static final playlistSongsDb = Hive.box<PlaylistSongModel>('playlist_songs');

bool isPlaylistSong(SongsModel song){

  for (PlaylistSongModel element in playlistNotifier.value ) {
    if(song.id==element.song.id){
       return true;

    }
  }
  return false;
}

  static Future<void> addSongToPlaylist(PlaylistSongModel song) async {
    playlistSongsDb.put(song.song.id, song);
    getSongsFromDb(song.playlistName!);

  }

  static Future<void> getSongsFromDb(String playListName) async {
    playlistNotifier.value.clear();
     for (PlaylistSongModel song in playlistSongsDb.values) {
      if(song.playlistName==playListName){
       playlistNotifier.value.add(song); 
      }
     
  }
   print(playlistSongsDb.values);
     print(playlistNotifier.value);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deleteSongFromPlaylist(PlaylistSongModel song) async {
    await playlistSongsDb.delete(song.song.id);
    getSongsFromDb(song.playlistName!);
  }
}
