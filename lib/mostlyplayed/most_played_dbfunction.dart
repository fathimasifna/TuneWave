// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../database/fuctions/all_music_db_functions.dart';
import '../database/model/data_model.dart';
import 'most_played_model.dart';

final ValueNotifier<List<SongsModel>> mostlyPlayedNotifier = ValueNotifier([]);
final mostlyBox = Hive.box<MostPlayedModel>('mostlyPlayedBox');

List<MostPlayedModel> songList = [];

Future<void> addMostlyPlayed(MostPlayedModel song) async {
  int playCount = 1;

  playCount = songList.where((element) => element.id == song.id).length + 1;

  songList.add(song);
  song.playCount = playCount;

  if (playCount > 2 && !mostlyBox.containsKey(song.id)) {
    mostlyBox.put(song.id, song);
  }

  await getAllPlayed();
  mostlyPlayedNotifier.notifyListeners();
}

getAllPlayed() async {
  List<MostPlayedModel> songList = [];
  songList = mostlyBox.values.toSet().toList();

  mostlyPlayedNotifier.value.clear();

  for (var song in songList) {
    for (var element in allSongsData) {
      if (song.id == element.id) {
        mostlyPlayedNotifier.value.add(element);
      }
    }
  }
  mostlyPlayedNotifier.notifyListeners();
}
