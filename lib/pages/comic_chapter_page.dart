import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';

class ChapterPage extends StatelessWidget {
  final Comic comic;
  final String imageUrl;

  const ChapterPage({super.key, required this.comic, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: FutureBuilder(
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            List data = snapshot.data;
            children = <Widget>[
              Text(comic.title),
              ImageWidget(imageUrl: imageUrl),
              Row(
                children: [
                  Text(comic.views),
                ],
              ),
              ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(data[index]['name']),
                      ),
                    );
                  }
              )
            ];
          }
          return Column(
            children: children,
          );
        }),
        future: comic.getComicChapters(),
      ),
    );
  }
}
