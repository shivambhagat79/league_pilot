import 'package:flutter/material.dart';
import 'package:hunger_games/pages/tournament/gallery.dart';

class DashboardGallery extends StatelessWidget {
  const DashboardGallery({super.key});

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
        child: Row(
          children: [
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
              ] +
              List.generate(8, (index) {
                return Container(
                  width: 120,
                  height: 200,
                  margin: EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/components/gallery.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
