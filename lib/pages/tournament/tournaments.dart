import 'package:flutter/material.dart';
import 'package:hunger_games/pages/tournament/home.dart';
import 'package:hunger_games/services/tournament_service.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  final TournamentService _tournamentService = TournamentService();
  late List<Map<String, String>> _tournaments;
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final tournaments = await _tournamentService.getActiveTournaments();

    setState(() {
      _tournaments = tournaments;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

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
                    // shadows: [
                    //   Shadow(
                    //     color: Colors.black.withAlpha(120),
                    //     blurRadius: 9,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                ),
                SizedBox(height: 50),
                _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Column(
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
                                        builder: (context) => HomePage(
                                          tournamentId:
                                              tournament["tournamentId"]!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tournament["tournamentName"]!,
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
            ),
          ),
        ),
      ),
    );
  }
}
