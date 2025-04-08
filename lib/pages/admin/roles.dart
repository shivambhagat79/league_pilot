import 'package:flutter/material.dart';
import 'package:hunger_games/pages/auth/admin_auth.dart';
import 'package:hunger_games/pages/auth/scorekeeper_auth.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.shade300,
              Colors.teal.shade900,
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: double.maxFinite,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Admin Roles',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Overcame",
                letterSpacing: 3,
              ),
            ),
            Text(
              "Please select your role to continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAuthPage(),
                  ),
                );
              },
              icon: Icon(Icons.admin_panel_settings),
              label: Text('Administrator'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(260, 60),
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScorekeeperAuthPage(),
                  ),
                );
              },
              icon: Icon(Icons.scoreboard),
              label: Text('Scorekeeper'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(260, 60),
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "© League Pilot. All rights reserved.",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
