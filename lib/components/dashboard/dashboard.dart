import 'package:flutter/material.dart';
import 'package:hunger_games/components/dashboard/dashboardAppBar.dart';
import 'package:hunger_games/components/dashboard/exploreButtons.dart';
import 'package:hunger_games/components/dashboard/heading.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 5,
      radius: const Radius.circular(10),
      controller: scrollController,
      child: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          DahsboardAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Heading(
                  text: "EXPLORE",
                ),
                ExploreButtons(),
                Heading(text: "GALLERY"),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: List.generate(
                            4,
                            (index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    "assets/images/components/gallery.jpg",
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                )),
                      ),
                    )),
                Heading(text: "CAMPUS MAP"),
                Container(
                    height: 250,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/components/map.png",
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                      ),
                    )),
                Heading(text: "CONTACT US"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
