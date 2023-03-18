import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../comics.dart';
import '../bookmarks.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({
    Key? key,
    required this.comic,
  }) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Consumer<Bookmarks>(
      builder: (ctx, bookmarks, child) => IconButton(
          onPressed: () {
            if (bookmarks.findComicById(comic.id)) {
              bookmarks.removeFromBookmark(comic.id);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${comic.title} removed from bookmarks'),
                  duration: const Duration(milliseconds: 1500)));
            } else {
              bookmarks.addToBookmark(comic);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${comic.title} added to bookmarks'),
                duration: const Duration(milliseconds: 1500),
              ));
            }
          },
          icon: Icon(
            bookmarks.findComicById(comic.id)
                ? Icons.bookmark_added
                : Icons.bookmark_add,
          )),
    );
  }
}
