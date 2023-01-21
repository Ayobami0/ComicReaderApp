import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';



class ComicDisplayTile extends StatelessWidget {
  final Comic comic;
  

  const ComicDisplayTile({
    Key? key,
    required this.comic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: GestureDetector(
          onTap: () {
            print('tapped');
            Navigator.pushNamed(context, '/comic', arguments: {'comic':comic});
            },
          child: GridTileBar(
            backgroundColor: Colors.black,
            title: Text(comic.title),
            subtitle: Row(
              children: [
                Text(comic.views),
              ],
            ),
            trailing: IconButton(
                onPressed: () {print('pressed');},
                icon: const Icon(
                  Icons.bookmark_add,
                )
            ),
          ),
        ),
        child: Container(
            child: ImageWidget(imageUrl: comic.imageLink,))
    );
  }
}