import 'package:flutter/material.dart';
import 'package:hunger_games/utils/url_launchers.dart';

class DashboardContacts extends StatelessWidget {
  final Map<String, dynamic> tournamentData;
  DashboardContacts({super.key, required this.tournamentData});
  final TextStyle _phoneNumberStyle = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(220),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Contact us",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Overcame",
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.blue.shade900,
                      ),
                      Text(
                        " Organising Team:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          phoneLauncher(tournamentData["organiser"]);
                        },
                        child: Text(
                          "+91 ${tournamentData['organiser']}",
                          style: _phoneNumberStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Colors.teal.shade900,
                      ),
                      Text(
                        " Medical Assistance:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          phoneLauncher(tournamentData["medical"]);
                        },
                        child: Text(
                          "+91 ${tournamentData['medical']}",
                          style: _phoneNumberStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.red.shade900,
                      ),
                      Text(
                        " Security:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          phoneLauncher(tournamentData["security"]);
                        },
                        child: Text(
                          "+91 ${tournamentData['security']}",
                          style: _phoneNumberStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.deepPurple.shade900,
                      ),
                      Text(
                        " Email:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          emailLauncher(tournamentData["organiserEmail"]);
                        },
                        child: Text(
                          tournamentData['organiserEmail'],
                          style: _phoneNumberStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
