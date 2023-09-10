import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'most_played_model.g.dart';

@HiveType(typeId: 3)
class MostPlayedModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late String title;

  @HiveField(2)
  String? subtitle;

  @HiveField(3)
  late String uri;

  @HiveField(4)
  int playCount = 0;

  MostPlayedModel({
    this.id,
    this.subtitle,
    required this.title,
    required this.uri,
  });
}
