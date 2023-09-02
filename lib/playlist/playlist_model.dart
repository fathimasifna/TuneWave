import 'package:hive/hive.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  late String? name;

  @HiveField(2)
  late String? subtitle;

  @HiveField(3)
  String? audioUri;

  @HiveField(4)
  late String? title;

  PlayListModel({
    required this.name,
    required this.subtitle,
    this.id,
    this.audioUri,
    required this.title,
  });

  // Copy constructor for renaming a song
  PlayListModel copyWith({
    String? name,
    String? subtitle,
    String? audioUri,
    String? title,
  }) {
    return PlayListModel(
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      audioUri: audioUri ?? this.audioUri,
      title: title ?? this.title,
    );
  }
}
