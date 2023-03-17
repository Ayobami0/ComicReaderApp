import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ComicImagesPage extends StatelessWidget {
  static const routeName = '/readChapter';

  const ComicImagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Comic comic = routeArgs['comic']!;
    final int chapter = routeArgs['chapter']!;
    comic.lastChapterIndex = chapter;
    return Scaffold(
      body: FutureBuilder(
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
                  floating: true,
                  pinned: false,
                  title: Text('Chapter $chapter'),
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    data.values.map((e) => ImageWidget(imageUrl: e)).toList(),
                  )
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.error,
                size: 30,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        future: comic.getComicChapters(read: true, chapter: chapter),
      ),
    );
  }
}
