import 'package:comic_reader/pages/bookmarks_page.dart';
import 'package:comic_reader/pages/main_comic_page.dart';
import 'package:comic_reader/pages/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(controller: _tabController, tabs: const [
                Tab(
                  icon: Icon(Icons.schedule),
                ),
                Tab(
                  icon: Icon(Icons.local_fire_department),
                ),
                Tab(
                  icon: Icon(Icons.sort_by_alpha),
                ),
                Tab(
                  icon: Icon(Icons.bookmark_outline),
                ),
              ])
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: const [
          MainComicPage(sort: ''),
          MainComicPage(sort: 'topview'),
          MainComicPage(sort: 'az'),
          BookmarkPage(),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
        child: const Icon(Icons.search),
      ),
    );
  }
}
