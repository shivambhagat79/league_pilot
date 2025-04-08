import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hunger_games/components/gallery/full_page_image.dart';
import 'package:hunger_games/utils/gallery_utils.dart';

class GalleryTile extends StatefulWidget {
  final String url;
  const GalleryTile({super.key, required this.url});

  @override
  State<GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<GalleryTile> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() {
            _isTapped = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullPageImage(imageUrl: widget.url),
            ),
          );
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: formatImageUrl(widget.url),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: Colors.teal.shade900,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
