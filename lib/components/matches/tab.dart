import 'package:flutter/material.dart';
import 'package:hunger_games/services/tournament_service.dart';

class TabButtons extends StatefulWidget {
  final String selectedTab;
  final String selectedSport;
  final String tournamentId;
  final Function(String) onTabChange;
  final Function(String) onSportChange;

  const TabButtons({
    super.key,
    required this.tournamentId,
    required this.selectedTab,
    required this.selectedSport,
    required this.onTabChange,
    required this.onSportChange,
  });

  @override
  State<TabButtons> createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons> {
  final TournamentService _tournamentService = TournamentService();
  List<String> _sports = [];
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    setState(() {
      _sports = ['All', ...sports];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Column(
            children: [
              // Main Tab Buttons (Live Now / Upcoming / Results)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
// Reduced height
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Ensures space between buttons
                  children: [
                    // Live Now Button
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: widget.selectedTab == "live"
                              ? Theme.of(context).colorScheme.primary
                              : Colors.teal.shade900.withAlpha(40),
                          foregroundColor: widget.selectedTab == "live"
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.black.withAlpha(180),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {
                          widget.onTabChange("live");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.live_tv,
                              color: widget.selectedTab == "live"
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
                          backgroundColor: widget.selectedTab == "upcoming"
                              ? Theme.of(context).colorScheme.primary
                              : Colors.teal.shade900.withAlpha(40),
                          foregroundColor: widget.selectedTab == "upcoming"
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.black.withAlpha(180),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {
                          widget.onTabChange("upcoming");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: widget.selectedTab == "upcoming"
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
                          backgroundColor: widget.selectedTab == "results"
                              ? Theme.of(context).colorScheme.primary
                              : Colors.teal.shade900.withAlpha(40),
                          foregroundColor: widget.selectedTab == "results"
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.black.withAlpha(180),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {
                          widget.onTabChange("results");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: widget.selectedTab == "results"
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
                    children: _sports.map((sport) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FilterChip(
                          selected: widget.selectedSport == sport,
                          onSelected: (value) {
                            widget.onSportChange(sport);
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
