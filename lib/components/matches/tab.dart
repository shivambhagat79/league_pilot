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
    "Lawn Tennis",
    "Badminton",
    "Volleyball",
    "Hockey",
    "Chess"
  ]; // List of sports including "All"

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Tab Buttons (Live Now / Upcoming / Results)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
// Reduced height
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Ensures space between buttons
            children: [
              // Live Now Button
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: selectedTab == "Live Now"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.teal.shade900.withAlpha(40),
                    foregroundColor: selectedTab == "Live Now"
                        ? Theme.of(context).colorScheme.onPrimary
                        : Colors.black.withAlpha(180),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    onTabChange("Live Now");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.live_tv,
                        color: selectedTab == "Live Now"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.black.withAlpha(180),
                        size: 18,
                      ),
                      Text(
                        "  Live Now",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Upcoming Button
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: selectedTab == "Upcoming"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.teal.shade900.withAlpha(40),
                    foregroundColor: selectedTab == "Upcoming"
                        ? Theme.of(context).colorScheme.onPrimary
                        : Colors.black.withAlpha(180),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    onTabChange("Upcoming");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: selectedTab == "Upcoming"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.black.withAlpha(180),
                        size: 18,
                      ),
                      Text(
                        "  Upcoming",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Results Button
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: selectedTab == "Results"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.teal.shade900.withAlpha(40),
                    foregroundColor: selectedTab == "Results"
                        ? Theme.of(context).colorScheme.onPrimary
                        : Colors.black.withAlpha(180),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    onTabChange("Results");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: selectedTab == "Results"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.black.withAlpha(180),
                        size: 18,
                      ),
                      Text(
                        "  Results",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Rule (Divider)
        const Divider(
          thickness: 1.0,
          color: Colors.grey, // Light grey divider
          indent: 10,
          endIndent: 10,
        ),

        // Horizontally Scrollable Sports Tab Buttons
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sports.map((sport) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: FilterChip(
                    selected: selectedSport == sport,
                    onSelected: (value) {
                      onSportChange(sport);
                    },
                    label: Text(
                      sport,
                      style: TextStyle(
                        fontSize: 12,
                      ), // Adjust font size for better fit
                    ),
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
