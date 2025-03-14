import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/admin/admin_tournament.dart';
import 'package:hunger_games/pages/admin/create_tournament.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Example list of tournaments
  final List<Map<String, String>> tournaments = [
    {
      'name': "Aarohan'25",
      'hostInstitute': 'IIT Ropar',
    },
    {
      'name': "Inter IIT'25",
      'hostInstitute': 'IIT Kanpur',
    },
  ];

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
                          await saveAdminId('');
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
                  )),
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
      child: Column(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        title: Text(tournament['name']!),
                        subtitle: Text(tournament['hostInstitute']!),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdminTourrnamentPage(
                                title: tournament['name']!,
                              ),
                            ),
                          );
                        },
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
