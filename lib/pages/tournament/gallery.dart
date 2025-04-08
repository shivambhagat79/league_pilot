import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/gallery/gallery_tile.dart';

class Gallery extends StatelessWidget {
  final List<dynamic> imageUrls;
  const Gallery({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Gallery",
      child: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: imageUrls.map((url) {
            return GalleryTile(url: url);
          }).toList(),
        ),
      ),
    );
  }
}
