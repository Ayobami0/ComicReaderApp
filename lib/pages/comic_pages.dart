import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ComicImagesPage extends StatelessWidget {
  static const routeName = '/readChapter';
  @override
  Widget build(BuildContext context) {
    final _routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Comic comic = _routeArgs['comic']!;
    final int chapter = _routeArgs['chapter']!;
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext build, int index) {
                  return ImageWidget(imageUrl: data[index.toString()]);
                  // return Text('test');
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error,
                size: 30,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        future: comic.getComicChapters(read: true, chapter: chapter),
      ),
    );
  }
}
