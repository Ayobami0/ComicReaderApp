import 'package:comic_reader/mainpage.dart';
import 'package:comic_reader/pages/comic_pages.dart';
import 'package:comic_reader/pages/comic_chapter_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/comic': (context) => ChapterPage(),
        '/readChapter': (context) => ComicImagesPage(),
      },
    );
  }
}
