import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final String selectedSport;
  final Function(String) onSportChange;

  FilterButtons({
    super.key,
    required this.selectedSport,
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
    return Container(
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
    );
  }
}
