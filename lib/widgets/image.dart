import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  Map<String, String> headers = {'referer':'https://mangakakalot.com/'};
  
  // final double height, width;

  ImageWidget({
    super.key, 
    required this.imageUrl,
    headers
    // required this.height,
    // required this.width
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: ((context, url) => CircularProgressIndicator()),
      fit: BoxFit.contain,
      httpHeaders: headers,
      // height: height,
      // width: width,
    );
  }
}


