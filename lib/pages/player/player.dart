import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/player/create_team.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Player Portal",
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout?'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await savePlayerLoginState(false);
                    await savePlayerId('');
                    Navigator.of(context).pop();
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
            ),
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTeamPage(),
            ),
          );
        },
        label: Text('Create Team'),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Column(
        children: [
          Text(
            "Your Info",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: "Overcame",
                letterSpacing: 5,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
