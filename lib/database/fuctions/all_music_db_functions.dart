import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class AllMusicDBFunctions {
  Future<void> createMusicBox();
  Future<void> fetchAndAddMusicToBox();
}

class AllMusicFunctions implements AllMusicDBFunctions {
  AllMusicFunctions.internal();
  static AllMusicFunctions instance = AllMusicFunctions.internal();
  factory AllMusicFunctions() {
    return instance;
  }

  @override
  Future<Box<SongsModel>> createMusicBox() async {
    return await Hive.openBox<SongsModel>('music_box');
  }

  @override
  Future<void> fetchAndAddMusicToBox() async {
    final OnAudioQuery onAudioQuery = OnAudioQuery();
    final musicList = await onAudioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final musicBox = await createMusicBox();
    await musicBox.clear();
    await musicBox.addAll(musicList.asMap().entries.map((entry) => SongsModel(
          id: entry.key,
          title: entry.value.displayNameWOExt,
          subtitle: entry.value.artist,
          audioUri: entry.value.uri, name: '',
        )));
  }
}
