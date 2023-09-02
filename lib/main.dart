import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/database/fuctions/all_music_db_functions.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/playlist/playlist_model.dart';
import 'package:music_player/recentlyplayed/recent_model.dart';
import 'package:music_player/screens/splash.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  if (!Hive.isAdapterRegistered(SongsModelAdapter().typeId)) {
    Hive.registerAdapter(SongsModelAdapter());
  }
   if (!Hive.isAdapterRegistered(RecentListModelAdapter().typeId)) {
    Hive.registerAdapter(RecentListModelAdapter());
  }
    await Hive.openBox<SongsModel>('music_box');
    await Hive.openBox<SongsModel>('favorite_songs');
    await Hive.openBox<PlayListModel>('playlistDb');
    await Hive.openBox<RecentListModel>('recent_box');

  

  final permissionStatus = await Permission.storage.status;

  if (permissionStatus.isDenied) {
    final permissionResult = await Permission.storage.request();

    if (permissionResult.isGranted) {
      runApp(const MusicPlayer());
    } else if (permissionResult.isPermanentlyDenied) {
      await openAppSettings();
    }
  } else if (permissionStatus.isPermanentlyDenied) {
    await openAppSettings();
  } else {
    await AllMusicFunctions.instance.fetchAndAddMusicToBox();
    runApp(const MusicPlayer());
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      home: SplashScreaan(),
    );
  }
}
