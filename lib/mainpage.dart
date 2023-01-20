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
                children = <Widget>[
                  Expanded(
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 3 / 5),
                          itemBuilder: ((context, index) {
                            return Card(
                              elevation: 5,
                              child: ComicDisplayTile(
                                  comic: Comic.fromJson(data[index]),
                              ),
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
                children = <Widget>[
                  SizedBox(height: 100,),
                  Center(child: Image.asset('assets/loading/4M4x.gif')),
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
