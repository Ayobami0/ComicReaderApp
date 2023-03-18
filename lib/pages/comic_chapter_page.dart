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
        title: Text('Read ${comic.title}'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 3
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageWidget(imageUrl: comic.imageLink),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                comic.title,
                softWrap: true,
                style: const TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  Text(comic.views),
                  BookmarkIcon(comic: comic)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: comic.getComicChapters(),
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Map data = snapshot.data;
                    List chapters = data['chapters'].reversed.toList();
                    String description = data['description'];
                    List genres = data['genres'];
                    List authors = data['authors'];
                    String status = data['status'];
                    String lastUpdate = data['updated_time'];
                    return Column(
                      children: [
                        Row(
                          children: [
                            const Text('Author(s): '),
                            Wrap(
                              children: authors.map((e) => Text(e)).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: genres.map((e) => Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(e),
                          )).toList(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Status: $status'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Last Updated: $lastUpdate'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(description),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chapters.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  onTap: () => Navigator.pushNamed(
                                      context, ComicImagesPage.routeName,
                                      arguments: {'comic': comic, 'chapter': index+1}),
                                  title: Text(chapters[index]['name']),
                                ),
                              );
                            }),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ],
          ),
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
