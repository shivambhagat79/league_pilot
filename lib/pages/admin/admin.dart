import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/admin/admin_tournament.dart';
import 'package:hunger_games/pages/admin/create_tournament.dart';
import 'package:hunger_games/services/shared_preferences.dart';
import 'package:hunger_games/services/tournament_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TournamentService tournamentService = TournamentService();
  late List<Map<String, dynamic>> tournaments;
  bool _isLoading = true;

  Future<void> getActiveTournaments() async {
    String? adminEmail = await getAdminEmail();
    tournaments =
        await tournamentService.getTournamentsByAdminEmail(adminEmail!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getActiveTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Admin",
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout?'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await saveAdminLoginState(false);
                    await saveAdminEmail('');
                    await saveAdminId('');
                    await saveAdminType('');
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTournamentPage(),
            ),
          );
        },
        label: Text('Create Tournament'),
        icon: Icon(Icons.add),
      ),
      child: _isLoading
          ? LinearProgressIndicator()
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Your Tournaments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black54,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: tournaments
                      .map(
                        (tournament) => Column(
                          children: [
                            Divider(
                              height: 0,
                              thickness: 1,
                            ),
                            ListTile(
                              // contentPadding:
                              //     EdgeInsets.symmetric(horizontal: 30),
                              title: Text(tournament['tournamentName']!),
                              subtitle: Text(tournament['hostInstitute']!),
                              leading: tournament['status'] == 'active'
                                  ? LiveIcon()
                                  : Icon(Icons.lock),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AdminTourrnamentPage(
                                      title: tournament['tournamentName']!,
                                      tournamentId: tournament['tournamentId']!,
                                    ),
                                  ),
                                );
                              },
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  if (tournament['status'] == 'active')
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text('End Tournament'),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('End Tournament?'),
                                              content: Text(
                                                  'Are you sure you want to end this tournament?'),
                                              actions: [
                                                FilledButton(
                                                  onPressed: () async {
                                                    await tournamentService
                                                        .endTournament(tournament[
                                                            'tournamentId']!);
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    getActiveTournaments();
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('No'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      title: Text('Delete Tournament'),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Delete Tournament?'),
                                            content: Text(
                                                'Are you sure you want to Delete this tournament?'),
                                            actions: [
                                              FilledButton(
                                                onPressed: () async {
                                                  await tournamentService
                                                      .deleteTournament(
                                                          tournament[
                                                              'tournamentId']!);
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();

                                                  getActiveTournaments();
                                                },
                                                child: Text('Yes'),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('No'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
              ],
            ),
    );
  }
}

class LiveIcon extends StatefulWidget {
  const LiveIcon({super.key});

  @override
  State<LiveIcon> createState() => _LiveIconState();
}

class _LiveIconState extends State<LiveIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Icon(
        Icons.circle,
        color: Colors.red,
      ),
    );
  }
}
