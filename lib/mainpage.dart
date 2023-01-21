import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _page = 1;

  late Future _getAllComic;

  void _navigatePage(){
    setState(() {
      _getAllComic = getAllComicsJson(page: _page+1);
      _page++;
      print(_page);
    });
  }

  @override
  void initState() {
    _getAllComic = getAllComicsJson(page: _page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _getAllComic,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                dynamic data = snapshot.data;
                return Stack(children: <Widget>[
                  GridView.builder(
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
                      })
                  ),
                  Positioned(
                    bottom: 1,
                    left: 5,
                    child: ElevatedButton(
                        onPressed: () => _navigatePage(),
                        child: Text('PREV')
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 5,
                    child: ElevatedButton(
                        onPressed: () => _navigatePage(),
                        child: Text('NEXT')
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(children: <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ]),
                );
              } else {
                return Center(child: Image.asset('assets/loading/4M4x.gif'));
              }
            })));
  }
}
