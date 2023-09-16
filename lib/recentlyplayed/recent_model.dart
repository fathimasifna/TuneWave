import 'package:hive/hive.dart';
    part 'recent_model.g.dart';
@HiveType(typeId: 1)
class  RecentListModel extends HiveObject {
  @HiveField(0) 
   int? id;

  @HiveField(1)
 String? subtitle;

  @HiveField(2)
  String? audioUri;

  @HiveField(3)
  late String? title;

    RecentListModel({
    
     this.subtitle,
    this.id,
    this.audioUri,
    required this.title,
  });

 
}
