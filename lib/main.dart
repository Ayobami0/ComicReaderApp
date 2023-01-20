import 'package:comic_reader/comics.dart';
import 'package:comic_reader/mainpage.dart';
import 'package:comic_reader/pages/comic_pages.dart';
import 'package:comic_reader/pages/comic_chapter_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                HomePage(),
        ),
        GoRoute(
          path: '/comic',
          builder: (BuildContext context, GoRouterState state) =>
              ChapterPage(comic: state.extra as Comic),
        ),
        GoRoute(
          path: '/readChapter',
          builder: (BuildContext context, GoRouterState state) {
            Map data = state.extra as Map;
            return ComicImagesPage(
              comic: data['comic'] as Comic,
              chapter: data['chapter'],);
          }
        ),
      ]
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
