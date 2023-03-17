import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> getAllComicsJson({page = 1, sort = '', search = ''}) async {
  final response = await http.get(Uri.parse(
      'https://comics-scrapper.onrender.com/api/v1/comics/all?page=$page&sortby=$sort&s=$search'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Unable to get response');
  }
}

class Comic {
  final dynamic imageLink, id, title, description, views, author;
  int lastChapterIndex = 1;

  Comic({
    required this.imageLink,
    required this.id,
    required this.title,
    required this.description,
    required this.views,
    required this.author,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      description: json['metadata']['description'],
      views: json['metadata']['views'],
      imageLink: json['metadata']['image'],
      author: json['metadata']['author'],
    );
  }

  Future getComicChapters({read = false, chapter=1}) async {
    final response = read ? await http.get(Uri.parse(
        'https://comics-scrapper.onrender.com/api/v1/comic/read/chapters/$id?chap=$chapter')) : await http.get(Uri.parse(
        'https://comics-scrapper.onrender.com/api/v1/comic/read/chapters/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Unable to get response');
    }
  }
}
