import 'package:comic_reader/comics.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  // List<Map> itemList =  List.generate(24, (index) => {
  //     'id': index,
  //     'name': 'Manga',
  //     'ratings': '4.5',
  //     'views': '1.23M'
  //   }
  // ).toList();

  late List comicList;

  void _getComicsList() async{
    comicList = await getAllComicsJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Row(
              children: [
              ],
            ),
            Row(
              children: [],
            ),
            Flexible(
            child:GridView.builder(
              itemCount: itemList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
              itemBuilder: ((context, index) {
                  return GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1)),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        ],
                      )
                    ),
                );
              }),
            ))
          ],
      )
    );
  }
}
