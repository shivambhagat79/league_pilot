import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hunger_games/components/dashboard/dashboard_actions.dart';
import 'package:hunger_games/components/dashboard/dashboard_activities.dart';
import 'package:hunger_games/components/dashboard/dashboard_contacts.dart';
import 'package:hunger_games/components/dashboard/dashboard_gallery.dart';
import 'package:hunger_games/components/dashboard/dashboard_map.dart';
import 'package:hunger_games/services/tournament_service.dart';

class Dashboard extends StatefulWidget {
  final String tournamentId;
  const Dashboard({super.key, required this.tournamentId});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TournamentService _tournamentService = TournamentService();
  late Map<String, dynamic> _tournamentData;
  bool _isLoading = false;

  Future<void> _getTournamentData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> tournamentData =
        await _tournamentService.getTournamentById(widget.tournamentId);

    setState(() {
      _tournamentData = tournamentData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    _getTournamentData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: _isLoading
            ? LinearProgressIndicator()
            : Column(
                children: [
                  DashboardActivities(tournamentId: widget.tournamentId),
                  // DashboardActions(),
                  DashboardGallery(
                    imageUrls: _tournamentData["pictureUrls"],
                  ),
                  SizedBox(height: 10),
                  DashboardMap(
                    latitude: _tournamentData["latitude"],
                    longitude: _tournamentData["longitude"],
                  ),
                  DashboardContacts(
                    tournamentData: _tournamentData,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("© League Pilot. All rights reserved."),
                  ),
                  SizedBox(height: 80),
                ],
              ),
      ),
    );
  }
}
