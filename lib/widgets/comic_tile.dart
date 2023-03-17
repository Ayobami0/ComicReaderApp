import 'package:comic_reader/comics.dart';
import 'package:comic_reader/favourite.dart';
import 'package:comic_reader/pages/comic_chapter_page.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bookmark_icon.dart';



class ComicDisplayTile extends StatelessWidget {
  final Comic comic;
  

  const ComicDisplayTile({
    Key? key,
    required this.comic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChapterPage.routeName, arguments: {'comic':comic});
        },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: GridTileBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(comic.title),
              subtitle: Row(
                children: [
                  Text(comic.views),
                ],
              ),
              trailing: BookmarkIcon(comic: comic),
            ),
            child: Hero(
              tag: comic.id,
                child: ImageWidget(imageUrl: comic.imageLink,))
        ),
      ),
    );
  }
}

