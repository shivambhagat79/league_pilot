import 'package:flutter/material.dart';
import 'package:hunger_games/components/auth/scorekeeper_login_form.dart';
import 'package:hunger_games/components/auth/scorekeeper_reg_form.dart';

class ScorekeeperAuthPage extends StatefulWidget {
  const ScorekeeperAuthPage({super.key});

  @override
  State<ScorekeeperAuthPage> createState() => _ScorekeeperAuthPageState();
}

class _ScorekeeperAuthPageState extends State<ScorekeeperAuthPage> {
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
          physics: BouncingScrollPhysics(),
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
                  'Scorekeeper ${isLogin ? 'Login' : 'Registration'}',
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
                    ? ScorekeeperLoginForm(toggleAuth: toggleAuth)
                    : ScorekeeperRegForm(toggleAuth: toggleAuth),
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
