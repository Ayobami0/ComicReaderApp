import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';



class ComicDisplayTile extends StatelessWidget {
  final String title,views, url;
  

  const ComicDisplayTile({
    Key? key,
    required this.title,
    required this.views,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: GestureDetector(
          onTap: () {print('tapped');},
          child: GridTileBar(
            backgroundColor: Colors.black,
            title: Text(title),
            subtitle: Row(
              children: [
                Text(views),
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
            child: ImageWidget(imageUrl: url))
    );
  }
}