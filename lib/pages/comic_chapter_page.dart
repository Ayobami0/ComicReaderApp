import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({super.key});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData){
            children = <Widget>[
              
            ];
          }
          return Column(
            children: children,
          );
        }
      ),
    );
  }
}
