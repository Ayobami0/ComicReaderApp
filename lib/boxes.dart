import 'package:comic_reader/bookmarks.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes{
  static Box<Bookmark> getBookmarks() => Hive.box<Bookmark>('bookmarks');
}
