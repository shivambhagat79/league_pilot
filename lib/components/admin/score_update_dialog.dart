import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreUpdateDialog extends StatefulWidget {
  final Map<String, String>? match;

  const ScoreUpdateDialog({super.key, this.match});

  @override
  State<ScoreUpdateDialog> createState() => _ScoreUpdateDialogState();
}

class _ScoreUpdateDialogState extends State<ScoreUpdateDialog> {
  final _formKey = GlobalKey<FormState>();

  final _team1ScoreController = TextEditingController();
  final _team2ScoreController = TextEditingController();

  @override
  void initState() {
    _team1ScoreController.text = widget.match!["team_1_score"]!;
    _team2ScoreController.text = widget.match!["team_2_score"]!;
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
                  Text(widget.match!["team_1_name"]!),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: widget.match!["status"] == "Live Now",
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
                  Text(widget.match!["team_2_name"]!),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: widget.match!["status"] == "Live Now",
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
      actions: widget.match!["status"] == "Live Now"
          ? [
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
