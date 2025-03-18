import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/match_data.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/admin/create_match.dart';

class AdminTourrnamentPage extends StatefulWidget {
  final String title;
  const AdminTourrnamentPage({super.key, required this.title});

  @override
  State<AdminTourrnamentPage> createState() => _AdminTourrnamentPageState();
}

class _AdminTourrnamentPageState extends State<AdminTourrnamentPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MatchData(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: widget.title,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.sports_cricket),
            label: 'Match Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports),
            label: 'Sport Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Tournament Data',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateMatchPage(),
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              label: Text('Add Match'),
              icon: Icon(Icons.add),
            )
          : _selectedIndex == 1
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateMatchPage(),
                      ),
                    );
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  label: Text('Add Sport'),
                  icon: Icon(Icons.add),
                )
              : null,
      child: _pages[_selectedIndex],
    );
  }
}
