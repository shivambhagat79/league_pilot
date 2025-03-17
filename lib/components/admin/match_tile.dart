import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/score_update_dialog.dart';
import 'package:hunger_games/pages/admin/edit_match.dart';

class MatchTile extends StatefulWidget {
  final Map<String, String>? match;
  const MatchTile({super.key, this.match});

  @override
  State<MatchTile> createState() => _MatchTileState();
}

enum MenuOptions { edit, start, end, delete }

class _MatchTileState extends State<MatchTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0,
          thickness: 1,
        ),
        ListTile(
          leading: widget.match!["status"] == "Live Now"
              ? LiveIcon()
              : widget.match!["status"] == "Upcoming"
                  ? Icon(Icons.timer_sharp)
                  : Icon(Icons.lock),
          // isThreeLine: true,
          title: Text(
              "${widget.match!['team_1_name']!} v/s ${widget.match!['team_2_name']!}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.match!['sport']!),
              Text(
                  "${widget.match!['date']!} | ${widget.match!['start_time']!}"),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ScoreUpdateDialog(match: widget.match),
                ),
                icon: Icon(Icons.scoreboard_outlined),
              ),
              PopupMenuButton<MenuOptions>(
                icon: Icon(Icons.more_vert), // Three dot menu icon
                onSelected: (MenuOptions option) {
                  // Handle menu selection
                  switch (option) {
                    case MenuOptions.edit:
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditMatchPage(),
                        ),
                      );
                      break;
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
                                  onPressed: () {
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
                    case MenuOptions.delete:
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Match'),
                              content: Text(
                                  'Are you sure you want to start the match?\nThis action cannot be undone.'),
                              actions: [
                                FilledButton(
                                  onPressed: () {
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
                                  'Are you sure you want to start the match?\nThe scores will be locked and cannot be updated after this action.'),
                              actions: [
                                FilledButton(
                                  onPressed: () {
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
                  PopupMenuItem<MenuOptions>(
                    value: MenuOptions.edit,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  if (widget.match!["status"] == "Upcoming")
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
                  if (widget.match!["status"] == "Live Now")
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
                  PopupMenuItem<MenuOptions>(
                    value: MenuOptions.delete,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
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
