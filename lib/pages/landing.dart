import 'package:flutter/material.dart';
import 'package:hunger_games/pages/admin/admin.dart';
import 'package:hunger_games/pages/auth/admin_auth.dart';
import 'package:hunger_games/pages/player/player.dart';
import 'package:hunger_games/pages/auth/player_auth.dart';
import 'package:hunger_games/pages/tournament/tournaments.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.teal.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'League Pilot',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Overcame",
                letterSpacing: 3,
              ),
            ),
            Text(
              "Please chose your portal to continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TournamentsPage(),
                  ),
                );
              },
              icon: Icon(Icons.sports_esports),
              label: Text('Tournament'),
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
                bool isPlayerLoggedIn = await getPlayerLoginState();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        isPlayerLoggedIn ? PlayerPage() : PlayerAuthPage(),
                  ),
                );
              },
              icon: Icon(Icons.person),
              label: Text('Player Portal'),
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
                bool isAdminLoggedIn = await getAdminLoginState();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        isAdminLoggedIn ? AdminPage() : AdminAuthPage(),
                  ),
                );
              },
              icon: Icon(Icons.admin_panel_settings),
              label: Text('Admin Portal'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(260, 60),
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 50),
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
