import 'package:flutter/material.dart';

import 'comics.dart';

class Bookmarks with ChangeNotifier{

  List<Comic> _items = [];

  List<Comic> get items => [..._items];

  bool findComicById(comicId){
    var search = _items.where((element) => element.id == comicId);
    if(search.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  void addToBookmark(Comic comic){
    _items.add(comic);
    notifyListeners();
  }

  void removeFromBookmark(String comicId){
    _items.removeWhere((element) => element.id == comicId);
    notifyListeners();
  }

}
