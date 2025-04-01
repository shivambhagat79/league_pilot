import 'package:flutter/material.dart';
import 'package:hunger_games/components/points_table/sports_table.dart';
import 'package:hunger_games/services/points_service.dart';

class SportsTablesContainer extends StatefulWidget {
  final String tournamentId;
  const SportsTablesContainer({super.key, required this.tournamentId});

  @override
  State<SportsTablesContainer> createState() => _SportsTablesContainerState();
}

class _SportsTablesContainerState extends State<SportsTablesContainer> {
  final PointsService _pointsService = PointsService();
  late Stream<Map<String, List<Map<String, dynamic>>>> _sportsStream;
  bool _isLoading = false;

  Future<void> _fetchSportsData() async {
    setState(() {
      _isLoading = true;
    });

    Stream<Map<String, List<Map<String, dynamic>>>> sportsStream =
        _pointsService.streamAllSportsTables(widget.tournamentId);

    setState(() {
      _sportsStream = sportsStream;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSportsData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.teal.shade900.withAlpha(190),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    "Sports Tables",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 22,
                      fontFamily: 'Overcame',
                      color: Colors.black.withAlpha(190),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade900.withAlpha(190),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : StreamBuilder(
                  stream: _sportsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("No data available"),
                      );
                    }

                    Map<String, List<Map<String, dynamic>>> sportsData =
                        snapshot.data!;

                    return Column(
                      children: sportsData.entries.map((entry) {
                        String sport = entry.key.substring(6);
                        List<Map<String, dynamic>> standings = entry.value;

                        print(
                            "Sport: $sport, Standings: ${standings.toString()} entries");

                        return SportsTable(
                          sport: sport,
                          standings: standings,
                        );
                      }).toList(),
                    );
                  }),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text("© League Pilot. All rights reserved.",
                style: TextStyle(color: Colors.white.withAlpha(190))),
          ),
          SizedBox(height: 500),
        ],
      ),
    );
  }
}
