import 'package:comic_reader/comics.dart';
import 'package:comic_reader/widgets/comic_tile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(icon: const Icon(Icons.keyboard_arrow_left), onPressed: ()=>Navigator.pop(context),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            height: 40,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              controller: _textController,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 7),
              ),
            ),
          ),
          const Text(
            'Search Results',
            style: TextStyle(fontSize: 20),
          ),
          Text(searchText),
          Expanded(
              child: searchText.isEmpty
                  ? const NotFoundWidget()
                  : SearchResult(searchTerm: searchText))
        ]),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final String searchTerm;

  const SearchResult({Key? key, required this.searchTerm}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future<List> search() async {
    List listData = await getAllComicsJson(page: 0, search: widget.searchTerm);

    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: search(),
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return const NotFoundWidget();
          }
          return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 3 / 5),
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  child: ComicDisplayTile(
                    comic: Comic.fromJson(snapshot.data[index]),
                  ),
                );
              }));
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(Icons.error),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.search,
          size: 90,
          color: Theme.of(context).primaryColor,
        ),
        const Text(
          'No Results Found',
          style: TextStyle(fontSize: 20),
        ),
        const Text('Try a different search')
      ]),
    );
  }
}
