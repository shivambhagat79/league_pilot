import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/services/match_service.dart';

class ScoreUpdateDialogCricket extends StatefulWidget {
  final Map<String, dynamic> match;
  final String matchId;

  const ScoreUpdateDialogCricket(
      {super.key, required this.match, required this.matchId});

  @override
  State<ScoreUpdateDialogCricket> createState() =>
      _ScoreUpdateDialogCricketState();
}

class _ScoreUpdateDialogCricketState extends State<ScoreUpdateDialogCricket> {
  final _formKey = GlobalKey<FormState>();

  final _team1RunsController = TextEditingController();
  final _team2RunsController = TextEditingController();
  final _team1WicketsController = TextEditingController();
  final _team2WicketsController = TextEditingController();
  final _team1OversController = TextEditingController();
  final _team2OversController = TextEditingController();

  final MatchService _matchService = MatchService();

  @override
  void initState() {
    _team1RunsController.text =
        widget.match["scoreboard"][widget.match['teams'][0]]["runs"].toString();
    _team2RunsController.text =
        widget.match["scoreboard"][widget.match['teams'][1]]["runs"].toString();
    _team1WicketsController.text = widget.match["scoreboard"]
            [widget.match['teams'][0]]["wickets"]
        .toString();
    _team2WicketsController.text = widget.match["scoreboard"]
            [widget.match['teams'][1]]["wickets"]
        .toString();
    _team1OversController.text = widget.match["scoreboard"]
            [widget.match['teams'][0]]["overs"]
        .toString();
    _team2OversController.text = widget.match["scoreboard"]
            [widget.match['teams'][1]]["overs"]
        .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Scorecard'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.match["teams"][0],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team1RunsController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Runs",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter runs";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team1WicketsController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Wickets",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter wickets";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team1OversController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Overs",
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter overs';
                        }
                        // Validate using a regular expression:
                        final RegExp regex = RegExp(r'^\d+(\.[0-5])?$');
                        if (!regex.hasMatch(value)) {
                          return 'Invalid format';
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
                    Text(
                      widget.match["teams"][1],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team2RunsController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Runs",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter runs";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team2WicketsController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Wickets",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter wickets";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      enabled: widget.match["status"] == "live",
                      textAlign: TextAlign.center,
                      controller: _team2OversController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: "Overs",
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please overs';
                        }
                        // Validate using a regular expression:
                        final RegExp regex = RegExp(r'^\d+(\.[0-5])?$');
                        if (!regex.hasMatch(value)) {
                          return 'Invalid format';
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
      ),
      actions: widget.match["status"] == "live"
          ? [
              FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool success = await _matchService.updateCricketScoreboard(
                      matchId: widget.matchId,
                      team1Runs: int.tryParse(_team1RunsController.text) ?? 0,
                      team1Wickets:
                          int.tryParse(_team1WicketsController.text) ?? 0,
                      team1Overs: _team1OversController.text,
                      team2Runs: int.tryParse(_team2RunsController.text) ?? 0,
                      team2Wickets:
                          int.tryParse(_team2WicketsController.text) ?? 0,
                      team2Overs: _team2OversController.text,
                    );

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
