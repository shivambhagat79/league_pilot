import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hunger_games/components/common/heading_cut_card.dart';

class DashboardActivities extends StatelessWidget {
  const DashboardActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return HeadingCutCard(
      heading: "DASHBOARD",
      tail: Container(
        margin: EdgeInsets.only(top: 6),
        alignment: Alignment.center,
        width: double.maxFinite,
        child: Text(
          "RECENT ACTIVITY",
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontFamily: "Overcame",
            fontSize: 18,
            color: Colors.black.withAlpha(150),
          ),
        ),
      ),
      child: SizedBox(
          height: 200,
          child: FlutterCarousel(
            options: FlutterCarouselOptions(
              height: 400.0,
              showIndicator: true,
              slideIndicator: CircularSlideIndicator(),
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              initialPage: 0,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              floatingIndicator: false,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Football Mens",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontFamily: "Overcame",
                            fontSize: 18,
                            color: Colors.black.withAlpha(190),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "IIT Ropar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black.withAlpha(190)),
                            ),
                            Text("v/s"),
                            Text(
                              "IIT Kanpur",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black.withAlpha(190)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "9",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black.withAlpha(190)),
                            ),
                            Text("-"),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black.withAlpha(190)),
                            ),
                          ],
                        ),
                        Text(
                          "IIT Ropar won by 9 goals",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black.withAlpha(190)),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          )),
    );
  }
}
