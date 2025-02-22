import 'package:flutter/material.dart';

class TabButtons extends StatelessWidget {
  final String selectedTab;
  final String selectedSport;
  final Function(String) onTabChange;
  final Function(String) onSportChange;

  TabButtons({
    super.key,
    required this.selectedTab,
    required this.selectedSport,
    required this.onTabChange,
    required this.onSportChange,
  });

  final List<String> sports = [
    "All",
    "Football",
    "Cricket",
    "Basketball",
    "Tennis",
    "Badminton",
    "Volleyball",
    "Hockey",
    "Table Tennis",
    "Athletics"
  ]; // List of sports including "All"

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Tab Buttons (Live Now / Upcoming)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 80,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Live Now Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedTab == "Live Now" ? Colors.teal : Colors.teal[100],
                    foregroundColor:
                        selectedTab == "Live Now" ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    onTabChange("Live Now");
                  },
                  child: const SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.live_tv, size: 24),
                        Text("Live Now", style: TextStyle(fontSize: 16)),
                        SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Space between buttons

              // Upcoming Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedTab == "Upcoming" ? Colors.teal : Colors.teal[100],
                    foregroundColor:
                        selectedTab == "Upcoming" ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    onTabChange("Upcoming");
                  },
                  child: const SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.photo_library_outlined, size: 24),
                        Text("Upcoming", style: TextStyle(fontSize: 16)),
                        SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Rule (Divider)
        const Divider(
          thickness: 1.5,
          color: Colors.grey, // Light grey divider
          indent: 20,
          endIndent: 20,
        ),

        // Horizontally Scrollable Sports Tab Buttons
        Container(
          height: 60, // Reduced height (50% of the main tab buttons)
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sports.map((sport) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSport == sport
                          ? Colors.teal
                          : Colors.teal[100],
                      foregroundColor: selectedSport == sport
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      onSportChange(sport);
                    },
                    child: Text(sport),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
