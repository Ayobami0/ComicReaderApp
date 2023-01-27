import 'package:comic_reader/mainpage.dart';
import 'package:comic_reader/pages/comic_pages.dart';
import 'package:comic_reader/pages/comic_chapter_page.dart';
import 'package:comic_reader/pages/search_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  static const int _blackPrimaryValue = 0xFF000000;

  MaterialColor primaryBlack = const MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic Reader',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        ChapterPage.routeName: (context) => const ChapterPage(),
        ComicImagesPage.routeName: (context) => ComicImagesPage(),
        SearchPage.routeName: (context) => const SearchPage(),
      },
    );
  }
}
