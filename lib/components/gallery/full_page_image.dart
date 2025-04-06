import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hunger_games/utils/gallery_utils.dart';

class FullPageImage extends StatelessWidget {
  final String imageUrl;
  const FullPageImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 4.0,
            child: CachedNetworkImage(
              imageUrl: formatImageUrl(imageUrl),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Colors.teal.shade900,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
