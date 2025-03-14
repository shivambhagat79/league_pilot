import 'package:flutter/material.dart';

class MatchTile extends StatefulWidget {
  final Map<String, String>? match;
  const MatchTile({super.key, this.match});

  @override
  State<MatchTile> createState() => _MatchTileState();
}

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
                onPressed: () {},
                icon: Icon(Icons.scoreboard_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
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
