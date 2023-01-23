import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _textController = TextEditingController();

  @override
  void dispose(){
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(icon: Icon(Icons.search)),
          ),
          const Text('Search Results: '),
          Text(_textController.text)
        ]
      ),
    );
  }
}
