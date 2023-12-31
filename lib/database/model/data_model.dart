import 'package:hive/hive.dart';
    part 'data_model.g.dart';

@HiveType(typeId: 0)
class SongsModel{
  @HiveField(0)
  int? id;
  
  @HiveField(1)                         
  final String? title;
  
  @HiveField(2)
  final String? subtitle;
  
  @HiveField(3)
  bool isFavorite;
  
  @HiveField(4) 
  final String? audioUri;
  
  @HiveField(5) 
  final String? imageUri;
  

  SongsModel({
    required this.title,
    required this.subtitle,
    this.id,
    this.isFavorite = false,
    this.audioUri, 
    this.imageUri, 
    required String name, 
  });

  // get name => null;

  // copyWith({required String name}) {}
  
}
String boxname = 'Songs';

class SongBox {
  static Box<SongsModel>? _box;
  static Box<SongsModel> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
