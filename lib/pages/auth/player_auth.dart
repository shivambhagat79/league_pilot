import 'package:flutter/material.dart';
import 'package:hunger_games/components/auth/player_login_form.dart';
import 'package:hunger_games/components/auth/player_reg_form.dart';

class PlayerAuthPage extends StatefulWidget {
  const PlayerAuthPage({super.key});

  @override
  State<PlayerAuthPage> createState() => _PlayerAuthPageState();
}

class _PlayerAuthPageState extends State<PlayerAuthPage> {
  bool isLogin = true;

  void toggleAuth() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'League Pilot',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Overcame",
                    letterSpacing: 3,
                  ),
                ),
                Text(
                  'Player ${isLogin ? 'Login' : 'Registration'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Overcame",
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 50),
                (isLogin)
                    ? PlayerLoginForm(toggleAuth: toggleAuth)
                    : PlayerRegForm(toggleAuth: toggleAuth),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "© League Pilot. All rights reserved.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
