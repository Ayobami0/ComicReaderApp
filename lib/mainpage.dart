import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getAllComicsJson(),
            builder: ((context, snapshot) {
              List<Widget> children = [];
              if (snapshot.hasData) {
                dynamic data = snapshot.data;
                // print(Comic.fromJson(data[0]).title);
                children = <Widget>[
                  Expanded(
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1 / 2),
                          itemBuilder: ((context, index) {
                            return Container(
                              child: ComicDisplayTile(
                                  title: Comic.fromJson(data[index]).title,
                                  views: Comic.fromJson(data[index]).views,
                                  url: Comic.fromJson(data[index]).imageLink),
                            );
                          })))
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Column(children: children);
            })));
  }
}
