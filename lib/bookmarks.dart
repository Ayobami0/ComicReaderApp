import 'package:comic_reader/boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../comics.dart';

part 'bookmarks.g.dart';


class Bookmarks extends ChangeNotifier{

  final box = Boxes.getBookmarks();

  Future? addToBookmark(Comic comic){
    final bookmark = Bookmark()
    ..id = comic.id
    ..title = comic.title
    ..author = comic.author
    ..views = comic.views
    ..description = comic.description
    ..imageLink = comic.imageLink
    ..updateTime = comic.updateTime;

    box.put(comic.id, bookmark);
    notifyListeners();
  }

  void removeFromBookmark(String comicId){
    var comicToRemove = box.get(comicId);
    if (comicToRemove != null) {
      comicToRemove.delete();
    }
    notifyListeners();
  }

  bool findComicById(comicId){
    if (box.get(comicId) != null){
      return true;
    }
    else{
      return false;
    }
  }
}


@HiveType(typeId: 0)
class Bookmark extends HiveObject{
  @HiveField(0)
  late String? id;

  @HiveField(1)
  late String? title;

  @HiveField(2)
  late String? author;

  @HiveField(3)
  late String? description;

  @HiveField(4)
  late String? views;

  @HiveField(5)
  late String? imageLink;

  @HiveField(6)
  late String? updateTime;
}
