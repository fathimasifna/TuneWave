import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'most_played_model.g.dart';

@HiveType(typeId: 3)
class MostPlayedModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  String? subtitle;

  @HiveField(2)
  late String uri;

  @HiveField(3)
  bool isFavorite = false;

  @HiveField(4)
  int playCount = 0;

  MostPlayedModel({
    this.subtitle,
    required this.title,
    required this.uri,
  });
}
