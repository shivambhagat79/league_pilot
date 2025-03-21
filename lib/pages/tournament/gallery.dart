import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/tournament/sample_images.dart';
import 'package:hunger_games/pages/tournament/filter.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String selectedSport = "All";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> images = imageData.where((image) {
      bool sportMatch =
      (selectedSport == 'All' || image['sport'] == selectedSport);

      return sportMatch;
    }).toList();

    return Customscrollpage(
      title: 'GALLERY',
      child: Column(
        children: [
          // If no images are available, show a placeholder message
          (images.isEmpty)
              ? Container(
            height: 500,
            alignment: Alignment.center,
            child: Text(
              "No Images to Display.",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
              : GridView.count(
            shrinkWrap: true, // Ensures GridView doesn't expand infinitely
            crossAxisCount: 3, // Number of columns in the grid
            crossAxisSpacing: 4.0, // Spacing between columns
            mainAxisSpacing: 4.0, // Spacing between rows
            children: images
                .map((image) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(image['url']!),
            ))
                .toList(),
          ),

          // Footer Section
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text("© League Pilot. All rights reserved."),
          ),
          SizedBox(height: 80), // Adds spacing at the bottom
        ],
      ),
    );
  }
}
