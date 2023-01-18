import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  
  // final double height, width;

  const ImageWidget({
    super.key, 
    required this.imageUrl,
    // required this.height,
    // required this.width
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: ((context, url) => CircularProgressIndicator()),
      fit: BoxFit.contain,
      // height: height,
      // width: width,
    );
  }
}


