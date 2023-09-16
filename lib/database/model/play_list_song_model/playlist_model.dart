import 'package:hive/hive.dart';
import 'package:music_player/database/model/data_model.dart';
    part 'playlist_model.g.dart';
@HiveType(typeId: 2)
class PlaylistSongModel extends HiveObject{

@HiveField(0)
final SongsModel song;

@HiveField(1)  
  String? playlistName;

  PlaylistSongModel({
    required this.song,required this.playlistName
  });

}