import 'package:flutter/material.dart';
import 'package:hunger_games/pages/tournament/home.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  final _tournaments = [
    {
      "name": "Aarohan'25",
      "hostInstitute": "IIT Ropar",
    },
    {
      "name": "Inter IIT'25",
      "hostInstitute": "IIT Kanpur",
    },
    {
      "name": "IYSC'25",
      "hostInstitute": "IIT Ropar",
    }
  ];

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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Active\nTournaments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Overcame",
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(120),
                          blurRadius: 9,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    children: _tournaments
                        .map(
                          (tournament) => Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white.withAlpha(200),
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tournament["name"]!,
                                      style: TextStyle(
                                        color: Colors.teal.shade800,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      tournament["hostInstitute"]!,
                                      style: TextStyle(
                                        color: Colors.teal.shade500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
