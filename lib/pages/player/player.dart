import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
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
      child: Container(),
    );
  }
}
