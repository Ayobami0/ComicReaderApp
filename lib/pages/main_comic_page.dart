import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainComicPage extends StatefulWidget {

  final String sort;

  const MainComicPage({super.key, required this.sort});

  @override
  State<MainComicPage> createState() => _MainComicPageState();
}

class _MainComicPageState extends State<MainComicPage> with AutomaticKeepAliveClientMixin{
  final controller = ScrollController();
  int _page = 0;
  bool isLoading = false;


  List items = [];

  void _addToList() async {
    if (isLoading) return;
    isLoading = true;

    final responseList = await getAllComicsJson(
        page: _page + 1,
        sort: widget.sort);
    setState(() {
      items.addAll(responseList);
      _page++;
      isLoading = false;
    });
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      _page = 0;
      items.clear();
    });

    _addToList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _addToList();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        _addToList();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getAllComicsJson(page: _page, sort: widget.sort),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List data = items;
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                        controller: controller,
                        itemCount: data.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 2 / 3),
                        itemBuilder: ((context, index) {
                          if (index < data.length) {
                            return ComicDisplayTile(
                              comic: Comic.fromJson(data[index]),
                            );
                          } else {
                            return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        })),
                  ),
                );
              } else if (snapshot.hasError) {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: Center(
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
                  )
                );
              } else {
                return Center(child: SpinKitSpinningLines(color: Theme.of(context).primaryColor,));
              }
            }))
    );
  }
}
