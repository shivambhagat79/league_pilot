import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/score_update_dialog.dart';
import 'package:hunger_games/services/match_service.dart';
import 'package:hunger_games/services/tournament_service.dart';

class ScorekeeperMatchTile extends StatefulWidget {
  final Map<String, dynamic> match;
  final String matchId;
  const ScorekeeperMatchTile(
      {super.key, required this.match, required this.matchId});

  @override
  State<ScorekeeperMatchTile> createState() => _ScorekeeperMatchTileState();
}

enum MenuOptions { start, end }

class _ScorekeeperMatchTileState extends State<ScorekeeperMatchTile> {
  final MatchService _matchService = MatchService();
  final TournamentService _tournamentService = TournamentService();
  String _tournamentName = '';
  bool _isLoading = false;

  Future<void> _fetchTournamentName() async {
    setState(() {
      _isLoading = true;
    });
    String tournamentId = widget.match['tournament'];
    String tournamentName =
        await _tournamentService.getTournamentName(tournamentId);
    setState(() {
      _tournamentName = tournamentName;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTournamentName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0,
          thickness: 1,
        ),
        ListTile(
          leading: widget.match["status"] == "live"
              ? LiveIcon()
              : widget.match["status"] == "upcoming"
                  ? Icon(Icons.timer_sharp)
                  : Icon(Icons.lock),
          // isThreeLine: true,
          title: Text(
              "${widget.match['teams'][0]} v/s ${widget.match['teams'][1]}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isLoading ? Text("---") : Text(_tournamentName),
              Text(widget.match['sport']),
              Text(
                  "${widget.match['schedule']['date'].toDate().toString().split(' ')[0]} | ${widget.match['schedule']['starttime']['hour']}:${widget.match['schedule']['starttime']['minute']}"),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ScoreUpdateDialog(
                      match: widget.match, matchId: widget.matchId),
                ),
                icon: Icon(Icons.scoreboard_outlined),
              ),
              PopupMenuButton<MenuOptions>(
                icon: Icon(Icons.more_vert), // Three dot menu icon
                onSelected: (MenuOptions option) {
                  // Handle menu selection
                  switch (option) {
                    case MenuOptions.start:
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Start Match'),
                              content: Text(
                                  'Are you sure you want to start the match?'),
                              actions: [
                                FilledButton(
                                  onPressed: () async {
                                    bool success = await _matchService
                                        .startMatch(widget.matchId);

                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Match started!'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Failed to start match!'),
                                        ),
                                      );
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Yes'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          });
                      break;
                    case MenuOptions.end:
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('End Match'),
                              content: Text(
                                  'Are you sure you want to end the match?\nThe scores will be locked and cannot be updated after this action.'),
                              actions: [
                                FilledButton(
                                  onPressed: () async {
                                    bool success = await _matchService
                                        .endMatch(widget.matchId);

                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Match Ended!'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to end match!'),
                                        ),
                                      );
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Yes'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          });
                      break;
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<MenuOptions>>[
                  if (widget.match["status"] == "upcoming")
                    PopupMenuItem<MenuOptions>(
                      value: MenuOptions.start,
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text('Start'),
                        ],
                      ),
                    ),
                  if (widget.match["status"] == "live")
                    PopupMenuItem<MenuOptions>(
                      value: MenuOptions.end,
                      child: Row(
                        children: [
                          Icon(Icons.stop),
                          SizedBox(width: 8),
                          Text('End Match'),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LiveIcon extends StatefulWidget {
  const LiveIcon({super.key});

  @override
  State<LiveIcon> createState() => _LiveIconState();
}

class _LiveIconState extends State<LiveIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Icon(
        Icons.circle,
        color: Colors.red,
      ),
    );
  }
}
