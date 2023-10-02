import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/database/fuctions/all_music_db_functions.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:music_player/mostlyplayed/most_played_model.dart';
import 'package:music_player/database/model/play_list_song_model/playlist_model.dart';
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
  if (!Hive.isAdapterRegistered(MostPlayedModelAdapter().typeId)) {
    Hive.registerAdapter(MostPlayedModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlaylistSongModelAdapter().typeId)) {
    Hive.registerAdapter(PlaylistSongModelAdapter());
  }

  await Hive.openBox<SongsModel>('music_box');
  await Hive.openBox<SongsModel>('favorite_songs');

  await Hive.openBox<String>('playlistDb');
  await Hive.openBox<PlaylistSongModel>('playlist_songs');
  await Hive.openBox<RecentListModel>('recent_box');
  await Hive.openBox<MostPlayedModel>('mostlyPlayedBox');

  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await plugin.androidInfo;
  if (androidInfo.version.sdkInt < 33) {
    print(androidInfo.version.sdkInt);
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      final permissionResult = await Permission.storage.request();
      if (permissionResult.isGranted) {
        await AllMusicFunctions.instance.fetchAndAddMusicToBox();
        runApp(const MusicPlayer());
      } else if (permissionResult.isPermanentlyDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else if (permissionStatus.isGranted) {
      await AllMusicFunctions.instance.fetchAndAddMusicToBox();
      runApp(const MusicPlayer());
    }
  } else {
    final permissionStatus = await Permission.audio.request();
    if (permissionStatus.isGranted) {
      await AllMusicFunctions.instance.fetchAndAddMusicToBox();
      runApp(const MusicPlayer());
    } else {
      await openAppSettings();
    }
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