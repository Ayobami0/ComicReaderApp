import 'package:comic_reader/comics.dart';
import 'package:comic_reader/pages/comic_pages.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  static const routeName = '/comic';
  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    final _routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Comic>;
    final Comic comic = _routeArgs['comic']!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Comic'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ImageWidget(imageUrl: comic.imageLink),
            SizedBox(
              height: 20,
            ),
            Text(
              comic.title,
              style: TextStyle(fontSize: 24),
            ),
            Text(comic.description),
            Row(
              children: [
                Text(comic.views),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data;
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () => Navigator.pushNamed(
                                context, ComicImagesPage.routeName),
                            title: Text(data[index]['name']),
                          ),
                        );
                      });
                } else {
                  return Center(
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
            arguments: {'comic': comic, 'chapter': 1}),
        child: Text('READ'),
      ),
    );
  }
}
