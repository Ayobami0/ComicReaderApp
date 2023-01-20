import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChapterPage extends StatefulWidget {
  final Comic comic;
  // final String imageUrl;

  const ChapterPage({super.key, required this.comic});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Comic'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ImageWidget(imageUrl: widget.comic.imageLink),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.comic.title,
              style: TextStyle(fontSize: 24),
            ),
            Text(widget.comic.description),
            Row(
              children: [
                Text(widget.comic.views),
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
                            onTap: () => context.push('/readChapter', extra: {
                              'comic': widget.comic,
                              'chapter': data.length - index
                            }),
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
              future: widget.comic.getComicChapters(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/readChapter', extra: {
          'comic': widget.comic,
          'chapter': 1
        }),
        child: Text('READ'),
      ),
    );
  }
}
