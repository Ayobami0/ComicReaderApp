import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../bookmarks.dart';
import '../mainpage.dart';
import '../pages/comic_chapter_page.dart';
import '../pages/comic_pages.dart';
import '../pages/bookmarks_page.dart';
import '../pages/search_page.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  Hive.registerAdapter(BookmarkAdapter());


  await Hive.openBox<Bookmark>('bookmarks');

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
    return ChangeNotifierProvider(
      create: ((context) => Bookmarks()),
      child: MaterialApp(
        title: 'Comic Reader',
        theme: ThemeData(
          primarySwatch: primaryBlack,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          ChapterPage.routeName: (context) => const ChapterPage(),
          ComicImagesPage.routeName: (context) => const ComicImagesPage(),
          SearchPage.routeName: (context) => const SearchPage(),
          BookmarkPage.routeName: (context) => const BookmarkPage(),
        },
      ),
    );
  }
}
