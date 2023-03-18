import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  Map<String, String> headers = {'referer':'https://mangakakalot.com/'};
  

  ImageWidget({
    super.key, 
    required this.imageUrl,
    headers
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: ((context, url) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinKitFadingCircle(color: Theme.of(context).primaryColor,),
          )),
        ),
      )),
      fit: BoxFit.cover,
      httpHeaders: headers,
    );
  }
}


