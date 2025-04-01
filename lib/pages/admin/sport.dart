import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/match_service.dart';

class SportPage extends StatefulWidget {
  final String sport;
  final String tournamentId;
  const SportPage({super.key, required this.sport, required this.tournamentId});

  @override
  State<SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  final MatchService _matchService = MatchService();
  final List<String> _teams = [];
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: widget.sport,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Scoreboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Divider(height: 40, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Teams',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final controller = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Add Name of the Team:"),
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            label: Text("Team Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                setState(() {
                                  _teams.add(controller.text);
                                });
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add"),
                ),
              ],
            ),
            Column(
              children: _teams
                  .map((contingent) => Column(
                        children: [
                          ListTile(
                            title: Text(contingent),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _teams.remove(contingent);
                                });
                              },
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                        ],
                      ))
                  .toList(),
            ),
            Divider(height: 40, thickness: 1),
            SizedBox(height: 20),
            OutlinedButton(
              style: FilledButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Save Changes?"),
                    content: Text("Are you sure you want to save the changes?"),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Save"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 56,
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text("Save Changes"),
              ),
            ),
            SizedBox(height: 10),
            FilledButton(
              style: FilledButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("End Sport?"),
                          content: Text(
                              "Are you sure you want to end this sport?\nMedals will be awarded and locked after this action."),
                          actions: [
                            FilledButton(
                              onPressed: () async {
                                bool success = await _matchService.endSport(
                                  tournamentId: widget.tournamentId,
                                  sportName: widget.sport,
                                );

                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Sport ended successfully"),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to end sport"),
                                    ),
                                  );
                                }

                                Navigator.of(context).pop();
                              },
                              child: Text("End"),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ));
              },
              child: Container(
                height: 56,
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text("End Sport"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
