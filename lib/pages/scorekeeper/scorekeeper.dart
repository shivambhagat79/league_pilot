import 'package:flutter/material.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class ScorekeeperPage extends StatefulWidget {
  const ScorekeeperPage({super.key});

  @override
  State<ScorekeeperPage> createState() => _ScorekeeperPageState();
}

class _ScorekeeperPageState extends State<ScorekeeperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
            onPressed: () async {
              await saveAdminLoginState(false);
              await saveAdminEmail('');
              await saveAdminId('');
              await saveAdminType('');

              Navigator.of(context).pop();
            },
            child: Text("Logout")),
      ),
    );
  }
}
