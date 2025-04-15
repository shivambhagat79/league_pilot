import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/teamservice.dart';
import 'package:hunger_games/services/tournament_service.dart';

class CreateTeamPage extends StatefulWidget {
  final String tournamentId;
  final String contingent;
  const CreateTeamPage(
      {super.key, required this.tournamentId, required this.contingent});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final TournamentService _tournamentService = TournamentService();
  final TeamService _teamService = TeamService();
  late List<String> _sports;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _captainNameController = TextEditingController();
  final TextEditingController _captainEmailController = TextEditingController();
  final List<Map<String, String>> _players = [];
  bool _isLoading = false;
  String? _selectedSport;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    setState(() {
      _sports = sports;
      _isLoading = false;
    });
  }

  Future<void> _createTeam() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      if (_players.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add at least one player.'),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      String? teamId = await _teamService.createTeam(
        tournamentId: widget.tournamentId,
        contingentName: widget.contingent,
        gender: "Mixed",
        sport: _selectedSport!,
        captainName: _captainNameController.text,
        captainEmail: _captainEmailController.text,
        players: _players,
      );

      if (teamId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Team created successfully!'),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create team.'),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'Create Team',
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? LinearProgressIndicator()
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.sports),
                        labelText: 'Sport',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      value: _selectedSport,
                      items: _sports.map((sport) {
                        return DropdownMenuItem(
                          value: sport,
                          child: Text(sport),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSport = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a Sport' : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _captainNameController,
                      decoration: InputDecoration(
                        labelText: 'Captain Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a valid Name'
                          : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _captainEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Captain Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    Divider(
                      height: 50,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Players',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            final nameController = TextEditingController();
                            final emailController = TextEditingController();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Add Player Information:"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        label: Text("Name"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        label: Text("Email"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  FilledButton(
                                    onPressed: () {
                                      if (nameController.text.isNotEmpty &&
                                          emailController.text.isNotEmpty) {
                                        setState(() {
                                          _players.add({
                                            "name": nameController.text,
                                            "email": emailController.text
                                          });
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Add"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text("Add"),
                        ),
                      ],
                    ),
                    Column(
                      children: _players
                          .map(
                            (player) => Column(
                              children: [
                                ListTile(
                                  title: Text(player['name']!),
                                  subtitle: Text(player['email']!),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        _players.remove(player);
                                      });
                                    },
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 40.0),
                    FilledButton(
                      onPressed: _createTeam,
                      child: Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        height: 56,
                        child: Text(
                          'Create Team',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
