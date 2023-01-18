import 'package:flutter/material.dart';

class ComicDisplayTile extends StatelessWidget {
  final String title, rating, views;

  const ComicDisplayTile({
    Key? key,
    required this.title,
    required this.rating,
    required this.views
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: Column(
        children: [
          Text(title),
          Row(
            children: [
              Text(rating),
              Text(views)
            ],),
        ],
      ),
    );
  }
}
