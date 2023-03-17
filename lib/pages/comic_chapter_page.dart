import 'package:comic_reader/comics.dart';
import 'package:comic_reader/pages/comic_pages.dart';
import 'package:comic_reader/widgets/bookmark_icon.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  static const routeName = '/comic';

  const ChapterPage({super.key});
  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Comic>;
    final Comic comic = routeArgs['comic']!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Comic'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Hero(tag: comic.id,child: SizedBox(height: 300,child: ImageWidget(imageUrl: comic.imageLink))),
            const SizedBox(
              height: 20,
            ),
            Text(
              comic.title,
              softWrap: true,
              style: const TextStyle(fontSize: 24),
            ),
            Text(comic.description),
            Row(
              children: [
                Text(comic.views),
                BookmarkIcon(comic: comic)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data.reversed.toList();
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () => Navigator.pushNamed(
                                context, ComicImagesPage.routeName,
                                arguments: {'comic': comic, 'chapter': index+1}),
                            title: Text(data[index]['name']),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              future: comic.getComicChapters(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ComicImagesPage.routeName,
            arguments: {'comic': comic, 'chapter': comic.lastChapterIndex}),
        child: const Text('READ'),
      ),
    );
  }
}
