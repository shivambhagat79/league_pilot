import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hunger_games/pages/tournament/gallery.dart';
import 'package:hunger_games/utils/gallery_utils.dart';

class DashboardGallery extends StatefulWidget {
  final List<dynamic> imageUrls;
  const DashboardGallery({super.key, required this.imageUrls});

  @override
  State<DashboardGallery> createState() => _DashboardGalleryState();
}

class _DashboardGalleryState extends State<DashboardGallery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 200,
      width: double.maxFinite,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(children: [
          Container(
            height: 200,
            width: 80,
            margin: EdgeInsets.only(left: 10),
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.surface.withAlpha(150),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "G\nA\nL\nL\nE\nR\nY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Overcame",
                    fontSize: 15,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Gallery(),
                  ),
                );
              },
            ),
          ),
          widget.imageUrls.isNotEmpty
              ? Row(
                  children: widget.imageUrls
                      .map((url) {
                        return Container(
                          width: 120,
                          height: 200,
                          margin: EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              formatImageUrl(url),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white60,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      })
                      .toList()
                      .sublist(0, min(widget.imageUrls.length, 8)),
                )
              : Container(
                  margin: EdgeInsets.only(left: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "No images available",
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
        ]),
      ),
    );
  }
}
