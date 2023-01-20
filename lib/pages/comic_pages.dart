import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ComicImagesPage extends StatelessWidget {
  final Comic comic;
  final int chapter;

  const ComicImagesPage({Key? key, required this.comic, required this.chapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
