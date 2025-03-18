import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/services/match_service.dart';

class ScoreUpdateDialog extends StatefulWidget {
  final Map<String, dynamic> match;
  final String matchId;

  const ScoreUpdateDialog(
      {super.key, required this.match, required this.matchId});

  @override
  State<ScoreUpdateDialog> createState() => _ScoreUpdateDialogState();
}

class _ScoreUpdateDialogState extends State<ScoreUpdateDialog> {
  final _formKey = GlobalKey<FormState>();

  final _team1ScoreController = TextEditingController();
  final _team2ScoreController = TextEditingController();

  final MatchService _matchService = MatchService();

  @override
  void initState() {
    _team1ScoreController.text = widget.match["scoreboard"]["teamScores"]
            [widget.match['teams'][0]]
        .toString();
    _team2ScoreController.text = widget.match["scoreboard"]["teamScores"]
            [widget.match['teams'][1]]
        .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Scorecard'),
      content: Form(
        key: _formKey,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.match["teams"][0]),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: widget.match["status"] == "live",
                    textAlign: TextAlign.center,
                    controller: _team1ScoreController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter score";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("v/s"),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.match["teams"][1]),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: widget.match["status"] == "live",
                    textAlign: TextAlign.center,
                    controller: _team2ScoreController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter score";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: widget.match["status"] == "live"
          ? [
              FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool success = await _matchService.updateMatchScore(
                        matchId: widget.matchId,
                        scoreTeam1:
                            int.tryParse(_team1ScoreController.text) ?? 0,
                        scoreTeam2:
                            int.tryParse(_team2ScoreController.text) ?? 0);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Score Update Successfully!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update Score!'),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Update"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
            ]
          : [],
    );
  }
}
