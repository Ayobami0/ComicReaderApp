import 'package:comic_reader/boxes.dart';
import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkPage extends StatelessWidget {
  static const routeName = '/bookmarks';
  const BookmarkPage({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Boxes.getBookmarks().listenable(),
      builder: ((context, box, child) {
              final bookmarks = box.values.toList();
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3/5
                  ),
                  itemBuilder: (ctx, i) => ComicDisplayTile(comic: Comic.fromBookmark(bookmarks[i])),
                  itemCount: bookmarks.length,
                ),
              );
            })
    );
  }
}
