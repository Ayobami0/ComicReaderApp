import 'package:comic_reader/favourite.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatelessWidget {
  static const routeName = '/bookmarks';
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    Bookmarks bookmarks = Provider.of<Bookmarks>(context, listen: true);
    if (bookmarks.items.isEmpty){
      return Center(
        child: Column(
          children: const [
            Icon(Icons.sentiment_very_satisfied_sharp, size: 50,),
            SizedBox(height: 20,),
            Text("You haven't Bookmarked a comic", style: TextStyle(fontSize: 20),),
            Text('Add a comic', style: TextStyle(fontSize: 20)),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 3/5
        ),
        itemBuilder: (ctx, i) => ComicDisplayTile(comic: bookmarks.items[i]),
        itemCount: bookmarks.items.length,
      ),
    );
  }
}
